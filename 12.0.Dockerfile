FROM debian:stretch
MAINTAINER Le Filament <https://le-filament.com>

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8
ENV APT_DEPS='build-essential libldap2-dev libsasl2-dev python3-dev python3-wheel'

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
            fontconfig \
            git \
            libssl1.0-dev \
            libx11-6 \
            libxcb1 \
            libxext6 \
            libxrender1 \
            node-less \
            postgresql-client \
            python3-pip \
            python3-pyldap \
            python3-qrcode \
            python3-renderpm \
            python3-setuptools \
            python3-vobject \
            python3-watchdog \
            xfonts-75dpi \
            xfonts-base \
            xz-utils \
            && \
        curl -o wkhtmltox.deb -SL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb &&\
        echo '7e35a63f9db14f93ec7feeb0fce76b30c08f2057 wkhtmltox.deb' | sha1sum -c - &&\
        dpkg --force-depends -i wkhtmltox.deb &&\
        apt-get install -y --no-install-recommends ${APT_DEPS} &&\
        pip3 install -I -r https://raw.githubusercontent.com/OCA/OCB/12.0/requirements.txt &&\
        pip3 install simplejson WTForms &&\
        apt-get -y purge ${APT_DEPS} &&\
        apt-get -y autoremove &&\
        rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# Install Odoo and remove not French translations and .git directory to limit amount of data used by container
RUN set -x; \
        useradd --create-home --home-dir /opt/odoo --no-log-init odoo && \
        /bin/bash -c "mkdir -p /opt/odoo/{etc,odoo,additional_addons,private_addons,data,private}" &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/OCB.git /opt/odoo/odoo &&\
        rm -rf /opt/odoo/odoo/.git &&\
        find /opt/odoo/odoo/addons/*/i18n/ /opt/odoo/odoo/odoo/addons/base/i18n/ -type f -not -name 'fr.po' -delete &&\
        chown -R odoo:odoo /opt/odoo

# Install Odoo OCA default dependencies
RUN set -x; \
        mkdir -p /tmp/oca-repos/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/account-financial-reporting.git /tmp/oca-repos/account-financial-reporting &&\
        mv /tmp/oca-repos/account-financial-reporting/account_tax_balance /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/partner-contact.git /tmp/oca-repos/partner-contact &&\
        mv /tmp/oca-repos/partner-contact/partner_firstname /opt/odoo/additional_addons/ &&\
        rm -rf /tmp/oca-repos/ &&\
        find /opt/odoo/additional_addons/*/i18n/ -type f -not -name 'fr.po' -delete &&\
        chown -R odoo:odoo /opt/odoo 

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
