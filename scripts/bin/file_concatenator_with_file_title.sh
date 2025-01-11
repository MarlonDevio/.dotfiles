#!/bin/bash

# Initialize an empty variable to store all content
all_content=""

# Loop through all files provided as arguments
for file in "$@"; do
    # Add file name as a separator
    all_content+="===== $file =====\n"
    
    # Append file content
    all_content+="$(cat "$file")\n\n"
done

# Copy all content to clipboard
echo -e "$all_content" | pbcopy

echo "All files have been concatenated and copied to clipboard."
