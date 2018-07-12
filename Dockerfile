FROM bitwalker/alpine-elixir:1.6.6
MAINTAINER Florian Kraft <schnuffifk@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

# Install hex
RUN mix local.hex --force
RUN mix local.rebar --force

ENV APP_HOME /app

WORKDIR $APP_HOME

COPY . .

CMD mix do deps.get, phx.server
