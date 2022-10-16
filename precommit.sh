#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
prettier -w baspp "*.md"
shellcheck -- *.sh
shfmt -w -- *.sh
./testrunner.sh
