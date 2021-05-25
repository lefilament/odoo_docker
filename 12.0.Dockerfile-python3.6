FROM python:3.6-slim-buster
MAINTAINER Le Filament <https://le-filament.com>

ENV APT_DEPS='build-essential libjpeg-dev libldap2-dev libsasl2-dev libpq-dev libxml2-dev libxslt1-dev python3-dev python3-wheel zlib1g-dev' \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PGDATABASE=odoo

RUN set -x; \
        apt-get update &&\
        apt-get install -y --no-install-recommends \
            curl \
            git \
            gnupg \
            libxml2 \
            libxslt1.1 \
            npm \
            openssh-client &&\
        echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' >> /etc/apt/sources.list.d/postgresql.list &&\
        curl -SL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - &&\
        curl -o wkhtmltox.deb -SL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb &&\
        echo 'ea8277df4297afc507c61122f3c349af142f31e5 wkhtmltox.deb' | sha1sum -c - &&\
        apt-get update &&\
        apt-get install -y --no-install-recommends ./wkhtmltox.deb &&\
        apt-get install -y --no-install-recommends postgresql-client &&\
        apt-get install -y --no-install-recommends ${APT_DEPS} &&\
        pip install -I -r https://raw.githubusercontent.com/OCA/OCB/12.0/requirements.txt &&\
        pip install simplejson WTForms zxcvbn PyYAML phonenumbers Werkzeug==0.14.1 &&\
        apt-get -y purge ${APT_DEPS} &&\
        apt-get -y autoremove &&\
        rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# Add Git Known Hosts
COPY ./ssh_known_git_hosts /root/.ssh/known_hosts

# Install Odoo and remove not French translations and .git directory to limit amount of data used by container
RUN set -x; \
        useradd -l --create-home --home-dir /opt/odoo --no-log-init odoo &&\
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
        git clone -b 12.0 --depth 1 https://github.com/OCA/account-financial-tools.git /tmp/oca-repos/account-financial-tools &&\
        mv /tmp/oca-repos/account-financial-tools/account_lock_date_update \
           /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/account-invoicing.git /tmp/oca-repos/account-invoicing &&\
        mv /tmp/oca-repos/account-invoicing/sale_timesheet_invoice_description \
           /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/bank-statement-import.git /tmp/oca-repos/bank-statement-import &&\
        mv /tmp/oca-repos/bank-statement-import/account_bank_statement_import_ofx /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/knowledge.git /tmp/oca-repos/knowledge &&\
        mv /tmp/oca-repos/knowledge/knowledge /tmp/oca-repos/knowledge/document_page /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/partner-contact.git /tmp/oca-repos/partner-contact &&\
        mv /tmp/oca-repos/partner-contact/partner_disable_gravatar \
           /tmp/oca-repos/partner-contact/partner_firstname \
           /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/project.git /tmp/oca-repos/project &&\
        mv /tmp/oca-repos/project/project_category \
           /tmp/oca-repos/project/project_status \
           /tmp/oca-repos/project/project_task_default_stage \
           /tmp/oca-repos/project/project_template \
           /tmp/oca-repos/project/project_timeline \
           /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/sale-workflow.git /tmp/oca-repos/sale-workflow &&\
        mv /tmp/oca-repos/sale-workflow/partner_contact_sale_info_propagation \
           /tmp/oca-repos/sale-workflow/partner_prospect \
           /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/server-auth.git /tmp/oca-repos/server-auth &&\
        mv /tmp/oca-repos/server-auth/auth_session_timeout \
           /tmp/oca-repos/server-auth/password_security \
           /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/server-brand.git /tmp/oca-repos/server-brand &&\
        mv /tmp/oca-repos/server-brand/disable_odoo_online \
           /tmp/oca-repos/server-brand/remove_odoo_enterprise \
           /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/server-tools.git /tmp/oca-repos/server-tools &&\
        mv /tmp/oca-repos/server-tools/base_search_fuzzy \
           /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/server-ux.git /tmp/oca-repos/server-ux &&\
        mv /tmp/oca-repos/server-ux/base_technical_features \
           /tmp/oca-repos/server-ux/date_range \
           /tmp/oca-repos/server-ux/mass_editing \
           /tmp/oca-repos/server-ux/mass_operation_abstract \
           /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/social.git /tmp/oca-repos/social &&\
        mv /tmp/oca-repos/social/base_search_mail_content \
           /tmp/oca-repos/social/mail_debrand \
           /opt/odoo/additional_addons/ &&\
        git clone -b 12.0 --depth 1 https://github.com/OCA/web.git /tmp/oca-repos/web &&\
        mv /tmp/oca-repos/web/web_environment_ribbon \
           /tmp/oca-repos/web/web_export_view \
           /tmp/oca-repos/web/web_responsive \
           /tmp/oca-repos/web/web_timeline \
           /opt/odoo/additional_addons/ &&\
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
