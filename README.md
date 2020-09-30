# PostgreSQL training material 2020-10

To run:
```sh
git clone https://github.com/mistmap/postgresql-training-finnish-2020-10
cd postgresql-training-finnish-2020-10
# Create the .env file with at least PGPASSWORD set in it.
# Also add DATABASE_URL in SQLAlchemy format if ipython-sql should be able to connect without parameters.
vi .env
# Create the passfile for PostgreSQL.
echo "*:*:*:*:$(grep '^PGPASSWORD=' .env | sed 's/^PGPASSWORD=//')" > pgpassfile
# Let the containers interact with these files.
chmod go+rwx ./exercises ./conf
chmod -R go+rw ./exercises/* ./conf/*
docker-compose up
```

After initialization it might make sense to add `DO_INIT_DB=false` or `DO_INIT_EXERCISES=false` in `.env`.

Also `conf/pgadmin4-servers.json` will likely require manual modifications.

The defaults have been set for a certain training environment.
If you run it yourself, check the configuration.
