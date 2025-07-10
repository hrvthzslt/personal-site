.DEFAULT_GOAL := help

help:
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

IMAGE_NAME=homepage-dev

build: # Build dev image
	docker build -t $(IMAGE_NAME) .

stop: # Stop the dev container
	-docker stop $(IMAGE_NAME)-container

start: stop # Start the dev container
	docker run -d --rm --name $(IMAGE_NAME)-container --hostname hugo-server -v $(PWD):/homepage -p 1313:1313 $(IMAGE_NAME)

shell: # Start interactive shell in the dev container
	docker exec -it $(IMAGE_NAME)-container /bin/bash

create-post: # Create a new post with the container
	./scripts/create-post
