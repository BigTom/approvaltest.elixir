#!/bin/sh

mix deps.get
mix test
mix credo --format=sarif --strict