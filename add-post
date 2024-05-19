#!/bin/sh

main() {
  title=$(echo "$@" | tr '[:upper:]' '[:lower:]' | sd ' ' '-')
  docker compose exec hugo hugo new posts/"$title".md
}

main "$@"
