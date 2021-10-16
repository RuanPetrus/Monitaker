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
command -v bmp2isc 1>/dev/null || error "bmp2isc is not installed."

for file in $(find "$1" -type f -iname '*.bmp' | tr '\n' ' ');
do
	bmp2isc "$file" 1>/dev/null || error "Failed to convert '$file'."
	rm $file
	output="${file%%.*}.data" # strip all extensions and use .data
	mv "${file}.s" "$output" 

	replace_with="$(basename $file)" # strip directories
	replace_with="${replace_with%%.*}" # strip extensions

	sed -i "s+${file}+${replace_with}+g" "$output"
	qnd "$output"
	echo "$file -> ${file%%.*}.data"
done
