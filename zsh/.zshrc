#Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
#
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# Source Oh My Zsh - THIS LINE IS ADDED
ZSH="$HOME/.oh-my-zsh" # Make sure this points to your Oh My Zsh installation
source $ZSH/oh-my-zsh.sh
source ~/.api_keys

# Plugins setup - THIS LINE IS ADDED
plugins=(git zsh-autosuggestions web-search zsh-syntax-highlighting zsh-interactive-cd)
# source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
#
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(starship init zsh)"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_comple
# ---- Zoxide (better cd) ---ents to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

function cpwdir() {
    # Prompt the user to enter a name for the alias
    
    name="$1"
    # Ensure the name is not empty
    if [ -z "$name" ]; then
        echo "Alias name cannot be empty. Please provide a valid name."
        return 1
    fi
    
    # Get the current directory
    dir=$(pwd)

    # Copy the current directory to the clipboard (optional)
    echo "$dir" | pbcopy

    # Check if the alias already exists in ~/.zshrc or ~/.aliases.zsh
    if grep -q "alias $name=" ~/.zshrc || grep -q "alias $name=" ~/.aliases.zsh; then
        echo "Alias '$name' already exists in ~/.zshrc or ~/.aliases.zsh."
    else
        # Create an alias in ~/.zshrc
        echo "alias $name='cd \"$dir\"'" >> ~/.aliases.zsh

        # Reload .zshrc to make the alias immediately available
        source ~/.zshrc

        echo "Alias '$name' created for directory '$dir'"
    fi
}
# ----- Bat (better cat) -----


# ---- Eza (better ls) -----

alias ls="eza --icons=always"

# ---- TheFuck -----

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

# - See the source code (completion.{bash,zsh}) for the details.
fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}


show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the argum-
#
# # Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# Add this function to your .zshrc
function search() {
  rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become(nvim {1} +{2})'
}
function spdf() {
     # Combine results from rg and pdfgrep
     ( rg --color=always --line-number --no-heading --smart-case ${*:-} ;
       pdfgrep -n -i ${*:-} *.pdf 2>/dev/null | sed 's/^/PDF:/' ) |
     fzf --ansi \
         --color hl:-1:underline,hl+:-1:underline:reverse \
         --delimiter : \
         --preview 'if [[ {1} == PDF:* ]]; then
                       pdftotext -f {2} -l {2} ${1#PDF:} - | bat --color=always -l txt -H {2};
                     else
                       bat --color=always {1} --highlight-line {2};
                     fi' \
         --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
         --bind 'enter:become(if [[ {1} == PDF:* ]]; then
                               open ${1#PDF:};
                             else
                               nvim {1} +{2};
                             fi)'
 }
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to
export PATH="~/bin:$PATH"

source ~/.aliases.zsh
export DOTNET_ROOT=/opt/homebrew/Cellar/dotnet/8.0.4/libexec
export PATH="$PATH:/Users/marlon/.dotnet/tools"

# # export PATH="$HOME/miniconda3/bin:$PATH"  # commented out by conda initialize
#
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/marlon/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/marlon/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/marlon/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/marlon/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

export PATH=/usr/local/share/dotnet:$PATH
export PATH=$PATH:$HOME/bin
export EDITOR=/opt/homebrew/bin/nvim
source /Users/marlon/.config/broot/launcher/bash/br


# Add to your .bashrc or .zshrc
function search_files() {
    fd --type f | fzf --preview "bat --style=numbers --color=always --line-range :500 {}"
}

function search_content() {
    rg --files | fzf --preview "rg --ignore-case --no-heading --line-number --color=always {q} {} | bat --style=numbers --color=always --line-range :500"
}

function search_pdfs() {
    fd --extension pdf | fzf --preview "pdfgrep -n {q} {} | bat --language=plain --style=plain --paging=never"
}
eval "$(gh copilot alias -- zsh)"

source /Users/marlon/.phpbrew/bashrc

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/marlon/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

set -o vi
export COLORTERM=truecolor
