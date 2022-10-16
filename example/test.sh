#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
../baspp example.bas  | petcat -w2 -o example.prg

c1541 -format example,11 d64 example.d64 -attach example.d64 8 -write example.prg example

pgrep "x64" || x64 -remotemonitor &>/dev/null&

wait-for localhost:6510

echo "autostart \"$(realpath example.d64)\"" | timeout 3 nc localhost 6510
