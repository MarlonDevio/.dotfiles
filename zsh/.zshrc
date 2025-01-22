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

# ----- bat (better cat) -----


# ---- eza (better ls) -----

alias ls="eza --icons=always"

# ---- thefuck -----

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ---- zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

# - see the source code (completion.{bash,zsh}) for the details.
fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}


show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export fzf_ctrl_t_opts="--preview '$show_file_or_dir_preview'"
export fzf_alt_c_opts="--preview 'eza --tree --color=always {} | head -200'"

# advanced customization of fzf options via _fzf_comprun function
# - the first argument to the function is the name of the command.
# - you should make sure to pass the rest of the argum-
#
# # set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#cbe0f0"
bg="#011628"
bg_highlight="#143652"
purple="#b388ff"
blue="#06bce4"
cyan="#2cf9ed"

export fzf_default_opts="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- use fd instead of fzf --

export fzf_default_command="fd --hidden --strip-cwd-prefix --exclude .git"
export fzf_ctrl_t_command="$fzf_default_command"
export fzf_alt_c_command="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# add this function to your .zshrc
function search() {
  rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become(nvim {1} +{2})'
}
# use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - the first argument to the function ($1) is the base path to

# source ~/.aliases.zsh
export dotnet_root=/opt/homebrew/cellar/dotnet/8.0.4/libexec
export path="$path:/users/marlon/.dotnet/tools"

# # export path="$home/miniconda3/bin:$path"  # commented out by conda initialize
#
# >>> conda initialize >>>
# !! contents within this block are managed by 'conda init' !!
# __conda_setup="$('/users/marlon/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/users/marlon/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/users/marlon/miniconda3/etc/profile.d/conda.sh"
#     else
#         export path="/users/marlon/miniconda3/bin:$path"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

export path=/usr/local/share/dotnet:$path
export path=$path:$home/bin
export editor=/opt/homebrew/bin/nvim


eval "$(gh copilot alias -- zsh)"


### managed by rancher desktop start (do not edit)
export path="/users/marlon/.rd/bin:$path"
### managed by rancher desktop end (do not edit)

set -o vi
export colorterm=truecolor
