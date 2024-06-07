.PHONY: help
.DEFAULT_GOAL := help

DC_EXITS := $(shell docker compose > /dev/null 2>&1 ; echo $$?)

ifeq ($(DC_EXITS),0)
	DOCKER_COMPOSE = docker compose
else
	DOCKER_COMPOSE = docker-compose
endif

help:
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: start
start: # Start the environment locally
	git submodule update --init --recursive
	$(DOCKER_COMPOSE) up -d;

.PHONY: stop
stop: # Stop the environment locally
	$(DOCKER_COMPOSE) down;

.PHONY: log
log: # Tail the logs the environment locally
	$(DOCKER_COMPOSE) logs -f

.PHONY: create-post
create-post: # Create a new post in the posts directory
	./scripts/create-post
