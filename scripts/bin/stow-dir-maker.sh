#!/bin/bash

# Ensure at least one package name is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 package_name [package_name2 ... package_nameN]"
    exit 1
fi

# Loop through all the arguments
for package_name in "$@"; do
    # Create the directory structure with intermediate directories
    mkdir -p "$package_name/.config/$package_name"
    
    # Print success message for each package
    echo "Directory structure $package_name/.config/$package_name created."
done
