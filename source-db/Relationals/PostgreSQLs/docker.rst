docker相关
##########


docker::

    docker pull postgres

start a postgres instance::

    $ docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres

    $ docker run -it --rm --network some-network postgres psql -h some-postgres -U postgres

Example stack.yml for postgres::

    # Use postgres/example user/password credentials
    version: '3.1'

    services:

      db:
        image: postgres
        restart: always
        environment:
          POSTGRES_PASSWORD: example

      adminer:
        image: adminer
        restart: always
        ports:
          - 8080:8080

使用::

    $ docker stack deploy -c stack.yml postgres
    or
    $ docker-compose -f stack.yml up


常用宏::

    POSTGRES_PASSWORD
    POSTGRES_USER
    POSTGRES_DB
    POSTGRES_INITDB_ARGS
    POSTGRES_INITDB_WALDIR
    POSTGRES_HOST_AUTH_METHOD
    PGDATA

实例::

    $ docker run -d \
      --name some-postgres \
      -e POSTGRES_PASSWORD=mysecretpassword \
      -e PGDATA=/var/lib/postgresql/data/pgdata \
      -v /custom/mount:/var/lib/postgresql/data \
      postgres

Configuration::

    $ # get the default config
    $ docker run -i --rm postgres cat /usr/share/postgresql/postgresql.conf.sample > my-postgres.conf

    $ # run postgres with custom config
    $ docker run -d --name some-postgres -v "$PWD/my-postgres.conf":/etc/postgresql/postgresql.conf -e POSTGRES_PASSWORD=<password> postgres -c 'config_file=/etc/postgresql/postgresql.conf'

    $ docker run -d --name some-postgres -e POSTGRES_PASSWORD=password postgres -c shared_buffers=256MB -c max_connections=200















