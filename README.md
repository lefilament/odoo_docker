# Basic Odoo docker including OCB 10.0/12.0/14.0 and some of OCA repos/addons

These docker images are now maintained on [Le Filament GitLab server](https://sources.le-filament.com/lefilament/odoo_docker)

# Description

This Docker is inspired from the ones from [Odoo](https://github.com/odoo/docker), [Tecnativa](https://github.com/Tecnativa/doodba) and [Elico Corporation](https://github.com/Elico-Corp/odoo-docker).

It creates a functional Odoo Docker of limited size (< 400 MB), including Odoo 10.0 or 12.0 from [OCA/OCB](https://github.com/oca/ocb), and also a few addons from [OCA](https://github.com/oca).

In order to reduce as much as possible the size of the Docker, only French translations are kept and .git directories are removed.
For people needing other languages than English or French, a 12.0_ml image is also provided.
Also, some extra modules may need python 3.6 for Odoo v12 (python 3.5 by default on 12.0 image), therefore a specific 12.0_py3.6 has been created.

The following OCA addons are included by default in this image (in v14.0):
```yaml
  - repo: account-financial-reporting
    modules:
     - account_tax_balance
  - repo: account-financial-tools
    modules:
     - account_lock_date_update
  # Not yet approved PR on v14
  #- repo: account-invoicing
  #  modules:
  #   - sale_timesheet_invoice_description
  - repo: bank-statement-import
    modules:
     - account_bank_statement_import_ofx
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
  - repo: server-auth
    modules:
     - password_security
  - repo: server-brand
    modules:
     - disable_odoo_online
     - portal_odoo_debranding
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
     - web_responsive
     - web_timeline
```

# Usage


This docker is built every nigth and pushed on [DockerHub](https://hub.docker.com/r/lefilament/odoo) and can be pulled by executing the following command:
```
docker pull lefilament/odoo:10.0
docker pull lefilament/odoo:12.0
docker pull lefilament/odoo:12.0_ml
docker pull lefilament/odoo:12.0_py3.6
docker pull lefilament/odoo:14.0
```

Note that v10.0 version is not updated nightly like the other ones since there are almost no change on corresponding codes. This 10.0 version might be updated in case security fixes are added to corresponding code.

It can also serve as base for deployments as described in this [Ansible role](https://sources.le-filament.com/lefilament/ansible-roles/docker_odoo)

docker-compose example is provided below:
```yaml
version: "2.1"
services:
    odoo:
        image: lefilament/odoo:14.0
        container_name: odoo14
        depends_on:
            - db
        tty: true
        volumes:
            - filestore:/opt/odoo/data:z
        restart: unless-stopped
        command:
            - odoo

    db:
        image: postgres:13-alpine
        container_name: odoo14_db
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
