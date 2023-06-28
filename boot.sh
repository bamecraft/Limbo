#!/bin/bash

docker compose down
git pull --recurse-submodules
./sync.sh
docker compose up --build --detach
