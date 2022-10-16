#!/usr/bin/env bash
cd "$(dirname "$0")"
find . -type f -name '*.bas' | entr -c ./test.sh
