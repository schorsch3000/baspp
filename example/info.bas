#!/usr/bin/env bash
echo "\$buildinfo\$ = \"Build on $(hostname) at $(date +%Y-%m-%d) by $(whoami)\"" | tr [:upper:] [:lower:]
