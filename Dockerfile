FROM elixir:1.13-alpine

WORKDIR /app

RUN apk update && apk add inotify-tools

ENV MIX_HOME /usr/lib/mix
RUN mix do local.hex --force, local.rebar --force

COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

COPY . .

RUN adduser -D phoenix
RUN chown -R phoenix: /app
USER phoenix

CMD ["mix", "phx.server"]
