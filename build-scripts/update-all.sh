#!/bin/sh

dir=`dirname $0`

declare -A commands

commands[bitcoin]="git pull"
commands[hexchat]="git pull"
commands[random]="git pull"

for repo in "${!commands[@]}"; do
	printf "%s\n" "$repo"
	cd $dir/../$repo/
	while read -r command; do
		$command
	done <<< "${commands[$repo]}"
done
