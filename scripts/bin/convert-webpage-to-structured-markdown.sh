#!/bin/bash

# Function to check if a string is a valid URL
is_url() {
  local url=$1
  if [[ $url =~ ^https?:// ]]; then
    return 0
  else
    return 1
  fi
}

# Check if exactly two arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <url> <file-name>"
  exit 1
fi

URL=$1
FILE_NAME=$2

# Validate the URL
if ! is_url "$URL"; then
  echo "Error: The first argument must be a valid URL."
  exit 1
fi

# Fetch the URL content and convert it using pandoc
curl -s "$URL" | pandoc -f html -t gfm-raw_html -o "$FILE_NAME"

echo "Content from $URL has been converted and saved to $FILE_NAME."
