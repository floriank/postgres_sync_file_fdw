# postgres_sync_file_fdw

A demo repository showing an elixir application importing CSV files using PostgreSQL file_fdw.

The application is written in [Elixir](https://elixir-lang.org) and demos the usage of [PostgreSQL file_fdw]() extension to synchronize a given CSV File (found in [./test/files/Company.csv]) with the services' own tables.

A more detailed guide on what is going on and why this is useful can be found in [my blog](https://floriank.github.io/post/the-steel-industry-file_fdw-and-postgres/).

# Setup

## with docker-compose

Requirements:

- [docker](https://docker.com)
- [docker-compose](https://docs.docker.com/compose/)

```
$ docker-compose up -d --build
```

To inspect the logs:

```
$ docker-compose logs -f app
```

To setup:

```
$ docker-compose exec app mix ecto.setup
```

To try out the sync:

```
$ docker-compose exec app iex -S mix
iex(1) > Synchronize.SqlModule.sync()
```

Should run one synchronisation - subsequent calls will not do anything, unless you edit the [original CSV file](./test/files/Company.csv).

## Bare metal

Requirements:

- Elixir 1.6
- PostgreSQL 9.x

```
$ mix phx.serve
```

Then create the database (credentials are taken from env, as seen in the [./docker-compose.yml]).

```
$ mix ecto.setup
```

And then, similar to the docker-setup:

```
$ iex -s mix
iex(1) > Synchronize.SqlModule.sync()
```

If __this does not work__, make sure your database server has access to the files under the path configured in the [migration](./priv/repo/migrations/20180712092837_add_foreign_company_table.exs).

