FROM debian:jessie
MAINTAINER Le Filament <https://le-filament.com>

# Install OS dependencies (some libraries, curl, git, less, postgresqlclient, sudo and wkhtmltox) and Odoo ones
ENV APT_DEPS='python-dev build-essential libxml2-dev libxslt1-dev libjpeg-dev libfreetype6-dev \
              liblcms2-dev libopenjpeg-dev libtiff5-dev tk-dev tcl-dev linux-headers-amd64 \
              libpq-dev libldap2-dev libsasl2-dev'
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
            fontconfig \
            git \
            node-less \
            libjpeg62-turbo \
            libtiff5 \ 
            libx11-6 \
            libxcb1 \
            libxext6 \
            libxml2 \
            libxrender1 \
            libxslt1.1 \
            node-less \
            postgresql-client \
            python-gevent \
            python-ldap \
            python-qrcode \
            python-renderpm \
            python-support \
            python-vobject \
            python-watchdog \
            sudo \
            xfonts-75dpi \
            xfonts-base \
        && curl -o wkhtmltox.deb -SL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.jessie_amd64.deb \
        && echo '4d104ff338dc2d2083457b3b1e9baab8ddf14202 wkhtmltox.deb' | sha1sum -c - \
        && dpkg --force-depends -i wkhtmltox.deb \
        && apt-get install -y --no-install-recommends ${APT_DEPS} \
        && curl https://bootstrap.pypa.io/get-pip.py | python /dev/stdin \
        && pip install -I -r https://raw.githubusercontent.com/OCA/OCB/10.0/requirements.txt \
        && pip install simplejson WTForms \
        && apt-get -y purge ${APT_DEPS} \
        && apt-get -y autoremove \
        && rm -rf /var/lib/apt/lists/* /tmp/* wkhtmltox.deb

# Install Odoo and remove not French translations and .git directory to limit amount of data used by container
RUN set -x; \
        useradd --create-home --home-dir /opt/odoo --no-log-init odoo \
        && /bin/bash -c "mkdir -p /opt/odoo/{etc,odoo,additional_addons,private_addons,data,private}" \
        && git clone -b 10.0 --depth 1 https://github.com/OCA/OCB.git /opt/odoo/odoo \
        && rm -rf /opt/odoo/odoo/.git \
        && find /opt/odoo/odoo/addons/*/i18n/ /opt/odoo/odoo/odoo/addons/base/i18n/ -type f -not -name 'fr.po' -delete \
        && chown -R odoo:odoo /opt/odoo 

# Install Odoo OCA default dependencies
RUN set -x; \
        mkdir -p /tmp/oca-repos/ \
        && git clone -b 10.0 --depth 1 https://github.com/OCA/account-financial-reporting.git /tmp/oca-repos/account-financial-reporting \
        && mv /tmp/oca-repos/account-financial-reporting/account_tax_balance /opt/odoo/additional_addons/ \
        && git clone -b 10.0 --depth 1 https://github.com/OCA/bank-statement-import.git /tmp/oca-repos/bank-statement-import \
        && mv /tmp/oca-repos/bank-statement-import/account_bank_statement_import_ofx \
              /tmp/oca-repos/bank-statement-import/account_bank_statement_import_qif \
              /opt/odoo/additional_addons/ \
        && git clone -b 10.0 --depth 1 https://github.com/OCA/knowledge.git /tmp/oca-repos/knowledge \
        && mv /tmp/oca-repos/knowledge/knowledge /tmp/oca-repos/knowledge/document_page /opt/odoo/additional_addons/ \
        && git clone -b 10.0 --depth 1 https://github.com/OCA/partner-contact.git /tmp/oca-repos/partner-contact \
        && mv /tmp/oca-repos/partner-contact/partner_firstname /opt/odoo/additional_addons/ \
        && git clone -b 10.0 --depth 1 https://github.com/OCA/server-tools.git /tmp/oca-repos/server-tools \
        && mv /tmp/oca-repos/server-tools/date_range \
              /tmp/oca-repos/server-tools/auth_session_timeout \
              /tmp/oca-repos/server-tools/auth_brute_force \
              /tmp/oca-repos/server-tools/password_security \
              /opt/odoo/additional_addons/ \
        && git clone -b 10.0 --depth 1 https://github.com/OCA/social.git /tmp/oca-repos/social \
        && mv /tmp/oca-repos/social/mail_restrict_follower_selection /opt/odoo/additional_addons/ \
        && git clone -b 10.0 --depth 1 https://github.com/OCA/web.git /tmp/oca-repos/web \
        && mv /tmp/oca-repos/web/web_export_view /opt/odoo/additional_addons/ \
        && rm -rf /tmp/oca-repos/ \
        && find /opt/odoo/additional_addons/*/i18n/ -type f -not -name 'fr.po' -delete \
        && chown -R odoo:odoo /opt/odoo 

# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./odoo.conf /opt/odoo/etc/odoo.conf
RUN chown odoo:odoo /opt/odoo/etc/odoo.conf

# Mount /opt/odoo/data to allow restoring filestore
VOLUME ["/opt/odoo/data/"]

# Expose Odoo services
EXPOSE 8069

# Set default user when running the container
USER odoo

# Start
ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]


# Metadata
ARG VCS_REF
ARG BUILD_DATE
ARG VERSION
LABEL org.label-schema.schema-version="$VERSION" \
      org.label-schema.vendor=LeFilament \
      org.label-schema.license=Apache-2.0 \
      org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.vcs-ref="$VCS_REF" \
      org.label-schema.vcs-url="https://github.com/lefilament/docker-odoo"

