#!/bin/sh

# Converts all files in $1 (must have .bmp extension) into .data files

error() { printf "ERROR: %s\n" "$1" >&2; exit 1; }

qnd() { # Quick n' Dirty Image Fix
	sed -i '/^$/d' "$1" # remove any empty lines
	sed -i '$ d' "$1" # remove last line
	tail -n 1 "$1" >> "$1" # duplicate new last line
}

# Error checking
[ ! -d "$1" ] && error "Not a valid directory."

for file in $(find "$1" -type f -iname '*.data' | tr '\n' ' ');
do
	qnd "$file"
	echo "$file"
done
