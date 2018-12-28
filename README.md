# Basic Odoo docker including OCB 10.0 and some of OCA repos/addons

[![](https://images.microbadger.com/badges/image/remifilament/odoo:10.0.svg)](https://microbadger.com/images/remifilament/odoo:10.0 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/remifilament/odoo:10.0.svg)](https://microbadger.com/images/remifilament/odoo:10.0 "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/license/remifilament/odoo:10.0.svg)](https://microbadger.com/images/remifilament/odoo:10.0 "Get your own license badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/remifilament/odoo:10.0.svg)](https://microbadger.com/images/remifilament/odoo:10.0 "Get your own commit badge on microbadger.com")

This Docker is inspired from the ones from [Odoo](https://github.com/odoo/docker), [Tecnativa](https://github.com/Tecnativa/doodba) and [Elico Corporation](https://github.com/Elico-Corp/odoo-docker).

It creates a functional Odoo Docker of limited size (< 400 MB), including Odoo 10.0 from [OCA/OCB](https://github.com/oca/ocb), and also a few addons from [OCA](https://github.com/oca).

In order to reduce as much as possible the size of the Docker, only French translations are kept and .git directories are removed.

This docker is automatically built on [DockerHub](https://cloud.docker.com/repository/docker/remifilament/odoo) and can be pulled by executing the following command:
```
docker pull remifilament/odoo:10.0
```

It can also serve as base for deployments as described in this [Ansible role](https://github.com/lefilament/ansible_role_odoo_docker)


# Credits

## Contributors

* Remi Cazenave <remi-filament>


## Maintainer

[![](https://le-filament.com/img/logo-lefilament.png)](https://le-filament.com "Le Filament")

This role is maintained by Le Filament
