#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
prettier -w baspp "*.md"
shellcheck -- *.sh
shfmt -w -- *.sh
./testrunner.sh
if grep -iRn "[t]odo" .; then
	echo T"ODOs found"
	exit 1
fi
