#!/bin/bash

for file in *; do
    # Skip directories
    if [ -d "$file" ]; then
        continue
    fi

    # Extract filename and extension
    filename="${file%.*}"
    extension="${file##*.}"

    # Replace spaces and dots in the filename
    new_filename=$(echo "$filename" | sed 's/[ .]/-/g')

    # Rename the file
    if [ "$filename" != "$new_filename" ]; then
        mv "$file" "$new_filename.$extension"
    fi
done
