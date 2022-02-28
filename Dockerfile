FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app

COPY mix.exs .
COPY mix.lock .

RUN npm install -g npm@8.5.2
RUN npm --prefix assets install
RUN npm --prefix assets run build

ENTRYPOINT ["tail", "-f", "/dev/null"]
