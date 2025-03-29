.DEFAULT_GOAL := help

DC_EXITS := $(shell docker compose > /dev/null 2>&1 ; echo $$?)

PREFIX_COMMAND = UID=$(shell id -u) GID=$(shell id -g)

ifeq ($(DC_EXITS),0)
	DOCKER_COMPOSE = $(PREFIX_COMMAND) docker compose
else
	DOCKER_COMPOSE = $(PREFIX_COMMAND) docker-compose
endif

help:
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

start: # Start the environment locally
	git submodule update --init --recursive
	$(DOCKER_COMPOSE) up -d;

stop: # Stop the environment locally
	$(DOCKER_COMPOSE) down;

log: # Tail the logs the environment locally
	$(DOCKER_COMPOSE) logs -f

shell: # Start an interactive shell in the hugo container
	$(DOCKER_COMPOSE) exec hugo sh

create-post: # Create a new post in the posts directory
	./scripts/create-post
