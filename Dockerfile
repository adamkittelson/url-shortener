FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app

COPY mix.exs .
COPY mix.lock .

RUN npm install -g npm@8.5.2

ENTRYPOINT ["tail", "-f", "/dev/null"]
