#!/bin/sh

# Applies the Quick n' Dirty fix to all .data files in $1

# Usually there is no need to run this script. The fix is already applied in
# the main mass_convert.sh script but this might be useful to convert leftover
# files created before it.

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
