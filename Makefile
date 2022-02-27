.PHONY: setup server test

# `make setup` will be used after cloning or downloading to fulfill
# dependencies, and setup the the project in an initial state.
# This is where you might download rubygems, node_modules, packages,
# compile code, build container images, initialize a database,
# anything else that needs to happen before your server is started
# for the first time
setup:
	docker compose build
	docker compose up -d
	docker compose exec web mix deps.get
	docker compose exec web mix ecto.create
	docker compose exec -e MIX_ENV=test web mix deps.get
	docker compose exec -e MIX_ENV=test web mix ecto.create

# `make server` will be used after `make setup` in order to start
# an http server process that listens on any unreserved port
# of your choice (e.g. 8080).
server:
	docker compose exec web iex -S mix phx.server

# `make test` will be used after `make setup` in order to run
# your test suite.
test:
	echo "Running back-end tests..."
	docker compose exec -e MIX_ENV=test web mix test
	# echo "Running front-end tests..."
	# docker compose exec -w /app/assets web npm test

