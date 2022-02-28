FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app

COPY mix.exs .
COPY mix.lock .
COPY assets/package.json assets/package-lock.json ./assets/

RUN npm install -g npm@8.5.2
RUN npm --prefix assets install

ENTRYPOINT ["tail", "-f", "/dev/null"]
