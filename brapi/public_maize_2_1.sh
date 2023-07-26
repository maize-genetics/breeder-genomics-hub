#!/usr/bin/env bash
createdb public_maize_2_1
createuser phg
createuser phgdev
createuser lcj34
psql -c "CREATE USER read_only_user WITH PASSWORD '$PGPASSWORD';"
cd /public_maize_2_1
zcat *.gz | psql -h /var/run/postgresql public_maize_2_1
psql -c 'GRANT pg_read_all_data TO read_only_user;'
psql -c 'REASSIGN OWNED BY phg TO postgres;DROP OWNED BY phg;'
psql -c 'REASSIGN OWNED BY phgdev TO postgres;DROP OWNED BY phgdev;'
psql -c 'REASSIGN OWNED BY lcj34 TO postgres;DROP OWNED BY lcj34;'
dropuser phg
dropuser phgdev
dropuser lcj34
