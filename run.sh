#!/bin/bash

set -eo pipefail

docker-compose -f docker-compose.dev.yml down

docker-compose -f docker-compose.dev.yml up --build --force-recreate --exit-code-from repro
