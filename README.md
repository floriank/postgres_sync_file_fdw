# postgres_sync_file_fdw

A demo repository showing an elixir application importing CSV files using PostgreSQL file_fdw.

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
$ docker-compose run app mix ecto.setup
```

## Bare metal

Requirements:

- Elixir 1.6
- PostgreSQL 9.x

```
$ mix phx.
```
