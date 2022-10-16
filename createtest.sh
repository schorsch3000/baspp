#!/usr/bin/env bash
set -e
me="$(realpath "$0")"
cd "$(dirname "$0")"/tests
mkdir "$1"
cd "$1"
echo "//$1" >input.bas
vim input.bas
../../baspp input.bas >output.bas
echo "input:"
cat input.bas
echo "output:"
cat output.bas
touch "$me"
