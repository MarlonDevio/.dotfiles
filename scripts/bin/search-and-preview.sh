#!/bin/zsh

search_and_preview() {
  local SEARCH_TERM=$1
  local SEARCH_DIR=$2

  if [ -z "$SEARCH_TERM" ]; then
    echo "Usage: search_and_preview <search-term> [search-dir]"
    return 1
  fi

  # Define ignore patterns
  local IGNORE_PATTERNS="--glob '!node_modules/*' --glob '!package-lock.json' --glob '!.git/*'"

  if [ -n "$SEARCH_DIR" ]; then
    # When a search directory is provided
    eval rg --column --line-number --no-heading --color=always $IGNORE_PATTERNS "$SEARCH_TERM" "$SEARCH_DIR" | fzf --ansi --delimiter : --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' --bind 'enter:execute(nvim {1} +{2})'
  else
    # When no search directory is provided, search in the current directory
    eval rg --column --line-number --no-heading --color=always $IGNORE_PATTERNS "$SEARCH_TERM" | fzf --ansi --delimiter : --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' --bind 'enter:execute(nvim {1} +{2})'
  fi
}

# If the script is called directly, execute the function with the provided arguments
if [[ "${(%):-%N}" == "${0}" ]]; then
  search_and_preview "$@"
fi
