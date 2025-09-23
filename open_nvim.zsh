#!/bin/bash
file="$1"
dir="$(dirname "$file")"

tmux a \; new-window -c "$dir" -n "$(basename "$file")" "nvim \"$file\""
