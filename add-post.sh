#!/usr/bin/sh

title=$(echo "$1" | tr '[:upper:]' '[:lower:]' | sd ' ' '_')

docker-compose exec hugo hugo new posts/"$title".md
