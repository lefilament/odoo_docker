# Basic Odoo docker including OCB 10.0/12.0 and some of OCA repos/addons

[![](https://images.microbadger.com/badges/image/lefilament/odoo:10.0.svg)](https://microbadger.com/images/lefilament/odoo:10.0 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/lefilament/odoo:10.0.svg)](https://microbadger.com/images/lefilament/odoo:10.0 "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/license/lefilament/odoo:10.0.svg)](https://microbadger.com/images/lefilament/odoo:10.0 "Get your own license badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/lefilament/odoo:10.0.svg)](https://microbadger.com/images/lefilament/odoo:10.0 "Get your own commit badge on microbadger.com")

[![](https://images.microbadger.com/badges/image/lefilament/odoo:12.0.svg)](https://microbadger.com/images/lefilament/odoo:12.0 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/lefilament/odoo:12.0.svg)](https://microbadger.com/images/lefilament/odoo:12.0 "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/license/lefilament/odoo:12.0.svg)](https://microbadger.com/images/lefilament/odoo:12.0 "Get your own license badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/lefilament/odoo:12.0.svg)](https://microbadger.com/images/lefilament/odoo:12.0 "Get your own commit badge on microbadger.com")

# Description

This Docker is inspired from the ones from [Odoo](https://github.com/odoo/docker), [Tecnativa](https://github.com/Tecnativa/doodba) and [Elico Corporation](https://github.com/Elico-Corp/odoo-docker).

It creates a functional Odoo Docker of limited size (< 400 MB), including Odoo 10.0 or 12.0 from [OCA/OCB](https://github.com/oca/ocb), and also a few addons from [OCA](https://github.com/oca).

In order to reduce as much as possible the size of the Docker, only French translations are kept and .git directories are removed.
For people needing other languages than English or French, a 12.0_ml image is also provided.

The following OCA addons are included (in v12.0):
```yaml
  - repo: account-financial-reporting
    modules:
     - account_tax_balance
  - repo: account-financial-tools
    modules:
     - account_lock_date_update
  - repo: account-invoicing
    modules:
     - sale_timesheet_invoice_description
  - repo: bank-statement-import
    modules:
     - account_bank_statement_import_ofx
  - repo: knowledge
    modules:
     - document_page
     - knowledge
  - repo: partner-contact
    modules:
     - partner_disable_gravatar
     - partner_firstname
  - repo: project
    modules:
     - project_category
     - project_status
     - project_task_default_stage
     - project_template
     - project_timeline
  - repo: sale-workflow
    modules:
     - partner_contact_sale_info_propagation
     - partner_prospect
  - repo: server-auth
    modules:
     - auth_session_timeout
     - password_security
  - repo: server-brand
    modules:
     - disable_odoo_online
     - remove_odoo_enterprise
  - repo: server-ux
    modules:
     - base_technical_features
     - date_range
     - mass_editing
  - repo: social
    modules:
     - base_search_mail_content
     - mail_debrand
  - repo: web
    modules:
     - web_environment_ribbon
     - web_export_view
     - web_responsive
     - web_timeline
```

# Usage


This docker is automatically built on [DockerHub](https://hub.docker.com/r/lefilament/odoo) and can be pulled by executing the following command:
```
docker pull lefilament/odoo:10.0
docker pull lefilament/odoo:12.0
docker pull lefilament/odoo:12.0_ml
```

It can also serve as base for deployments as described in this [Ansible role](https://github.com/lefilament/ansible_role_odoo_docker)

docker-compose example is provided below:
```yaml
version: "2.1"
services:
    odoo:
        image: lefilament/odoo:12.0
        container_name: odoo12
        depends_on:
            - db
        tty: true
        volumes:
            - filestore:/opt/odoo/data:z
        restart: unless-stopped
        command:
            - odoo

    db:
        image: postgres:10-alpine
        container_name: odoo12_db
        environment:
            POSTGRES_USER: "odoo"
            POSTGRES_PASSWORD: "odoo"
        volumes:
            - db:/var/lib/postgresql/data:z
        restart: unless-stopped

networks:
    default:
        driver_opts:
            encrypted: 1

volumes:
    filestore:
    db:
```

# Credits

## Contributors

* Remi Cazenave <remi-filament>


## Maintainer

[![](https://le-filament.com/img/logo-lefilament.png)](https://le-filament.com "Le Filament")

This role is maintained by Le Filament
