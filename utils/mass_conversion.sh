#!/bin/sh

# Converts all files in $1 (must have .bmp extension) into .data files

error() { printf "ERROR: %s\n" "$1" >&2; exit 1; }

[ ! -d "$1" ] && error "Not a valid directory."

for file in $(find "$1" -type f -iname '*.bmp' | tr '\n' ' ');
do
	# These are all chained. If one fails, the suceeding ones won't run.
	"$HOME/.local/bin/bmp2isc" "$file" 1>/dev/null || error "Failed to convert '$file'."
	rm $file
	output="${file%%.*}.data" # strip all extensions and use .data
	mv "${file}.s" "$output" 

	replace_with="$(basename $file)" # strip directories
	replace_with="${replace_with%%.*}" # strip extensions

	sed -i "s+${file}+${replace_with}+g" "$output"
	echo "$file -> ${file%%.*}.data"
done
