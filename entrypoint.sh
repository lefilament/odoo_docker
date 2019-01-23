#!/bin/bash

set -e

# set the postgres database host, port, user and password according to the environment
# and pass them as arguments to the odoo process if not present in the config file
: ${HOST:=${DB_PORT_5432_TCP_ADDR:='db'}}
: ${PORT:=${DB_PORT_5432_TCP_PORT:=5432}}
: ${USER:=${DB_ENV_POSTGRES_USER:=${POSTGRES_USER:='odoo'}}}
: ${PASSWORD:=${DB_ENV_POSTGRES_PASSWORD:=${POSTGRES_PASSWORD:='odoo'}}}

DB_ARGS=()
function check_config() {
    param="$1"
    value="$2"
    if ! grep -q -E "^\s*\b${param}\b\s*=" /opt/odoo/etc/odoo.conf ; then
        DB_ARGS+=("--${param}")
        DB_ARGS+=("${value}")
    else 
	value=`grep "^\s*\b${param}\b\s*=" /opt/odoo/etc/odoo.conf | cut -d "=" -f 2 | xargs`
    fi;
}
value=""
check_config "db_host" "$HOST"
export PGHOST=$value
check_config "db_port" "$PORT"
export PGPORT=$value
check_config "db_user" "$USER"
export PGUSER=$value
check_config "db_password" "$PASSWORD"
export PGPASSWORD=$value

if ! psql -l | grep $PGDATABASE; then
	echo "Database $PGDATABASE does not exist"
else
        psql -qc 'CREATE EXTENSION IF NOT EXISTS unaccent'
fi

case "$1" in
    -- | odoo)
        shift
        if [[ "$1" == "scaffold" ]] ; then
            exec /opt/odoo/odoo/odoo-bin -c /opt/odoo/etc/odoo.conf "$@"
        else
            exec /opt/odoo/odoo/odoo-bin -c /opt/odoo/etc/odoo.conf "$@" "${DB_ARGS[@]}"
        fi
        ;;
    -*)
        exec /opt/odoo/odoo/odoo-bin -c /opt/odoo/etc/odoo.conf "$@" "${DB_ARGS[@]}"
        ;;
    *)
        exec "$@"
esac

exit 1
