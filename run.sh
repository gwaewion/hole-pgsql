#!/bin/sh

if [ -z "$(ls -A "$POSTGRES_DATAPATH")" ]; then

	chown postgres:postgres $POSTGRES_DATAPATH
	su postgres -c "initdb $POSTGRES_DATAPATH"
	echo -e '\nhost\tall\tall\t0.0.0.0/0\tmd5' >> $POSTGRES_DATAPATH/pg_hba.conf
	sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" $POSTGRES_DATAPATH/postgresql.conf
	su postgres -c "echo \"alter user postgres with password '$POSTGRES_PASSWORD';\" | postgres --single -jE -D $POSTGRES_DATAPATH"
	mkdir /run/postgresql && chown postgres:postgres /run/postgresql
	su - postgres -c "postgres -D $POSTGRES_DATAPATH"

else

	su - postgres -c "postgres -D $POSTGRES_DATAPATH"

fi