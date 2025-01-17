alias gpt="open -n /Applications/ChatGPT.app/Contents/MacOS/ChatGPT"
alias cwr='~/bin/weekly-review-script.py'
alias install_composer="/Users/marlon/bin/install_composer.sh"
alias sth="~/bin/renamer.sh"
alias create_file_from_many="~/bin/file_filter_with_names_at_top.py"
alias mc='~/bin/stow-dir-maker.sh'
alias dcb='docker-compose build'
alias dcd='docker-compose down'
alias dcu='docker-compose up'
alias grep='grep --color=auto'
alias gtobs='cd /Users/marlon/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/MainSyncVault'
alias secondbrain='/Users/marlon/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/secondbrain'
alias brain='/Users/marlon/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/brain'
alias gen_wiki='~/bin/obsidian-linker/obsidian-linker.py'

alias daily_note='~/Scripts/open_daily_note.sh'
alias mrshoaff='nvim /Users/marlon/vaults/Life/Areas/MrShoaff.md'
alias dashdocs='cd "/Users/marlon/Library/Application Support/Dash/"'
alias t9='cd /Volumes/T9'
alias gitcommit='/Users/marlon/Scripts/gitcommit.sh'
alias to_webp='/Users/marlon/Scripts/rename_to_webp.sh'
alias xampp_rs='"sudo /Application/XAMPP/xamppfiles/xampp restart apache"'
alias apache_os='/Applications/XAMPP/manager-osx.app/Contents/MacOS/Application\ Manager'
alias npn='~/Scripts/new_programming_note.sh'
alias nnn='~/Scripts/new_networking_note.sh'
alias nnsn='~/Scripts/new_networking_school_note.sh'
alias gaw='cd /Applications/XAMPP/xamppfiles/htdocs/'
alias gawr='cd /Applications/XAMPP/xamppfiles/htdocs/reflexor/'
alias gce='gh copilot explain'
alias setwallpaper='osascript -e '\''tell application "Finder" to set desktop picture to POSIX file'\'
#utils
alias extract_font_sizes='/Users/marlon/Scripts/reg_extractor.py'

alias file_concat='~/bin/file_concatenator_with_file_title.sh'
# config alias
alias zconf="nvim ~/.zshrc"
alias zsrc="source ~/.zshrc"
alias wconf="nvim ~/.config/wezterm/wezterm.lua"
alias aconf='nvim ~/.aliases.zsh'
alias nconf='nvim ~/.config/nvim/'
alias aeconf='nvim ~/.config/aerospace/aerospace.toml'
alias tconf='nvim ~/.tmux.conf'

# directory alias
alias gtcss='cd "/Users/marlon/Library/Application Support/JetBrains/Rider2024.1/scratches"'

# development navigation alias


# tools alias
alias ws='/Users/marlon/Library/Application\ Support/JetBrains/Toolbox/scripts/webstorm'
alias phps='/Users/marlon/Library/Application\ Support/JetBrains/Toolbox/scripts/phpstorm'
alias url_to_md='/Users/marlon/bin/convert-webpage-to-structured-markdown.sh'
alias bfr='python3 ~/bin/batch_file_renamer.py'
alias pieces_run='~/bin/pieces_run.sh'
alias cdi='~/bin/cdi.sh'
# ---- Eza (better ls) -----

alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

alias ll='eza -l --icons'
alias la='eza -la --icons'

alias combine_files='python3 "/Users/marlon/bin/gpt-code-summarizer-to-file.py"'

# copy pwd
alias cpwd='pwd | pbcopy'

# search paths

search_notes(){
 /Users/marlon/bin/search-and-preview.sh "$1" "/Users/marlon/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/MainSyncVault"
}
alias sn='search_notes'
alias sf='/Users/marlon/bin/search-and-preview.sh'

alias ystart='yabai --start-service'
alias ystop='yabai --stop-service'

# tmux aliases
alias tl='tmux ls'
alias ta='tmux attach'
alias tcs='tmux new-session'
alias tcw='tmux new-window'
alias tkw='tmux kill-window' 
alias tks='tmux kill-session'
alias trw='tmux rename-window'

alias ala='aerospace list-apps'

# template alias
alias crgsap='/Users/marlon/bin/create-gsap.sh'
alias crnodets='/Users/marlon/bin/create-node-typescript.sh'
alias t9='/Volumes/marlon-t9/'

mv_to_docs() {
    cp -r "$1" /Volumes/marlon-t9/
}
alias cpt9=mv_to_docs
alias gtwin='cd "/Volumes/[C] Windows 11 (1)/Users/11306401"'

fdcopy() {
    fd "$1" | xargs -I {} sh -c 'echo "$(realpath "{}")" | pbcopy'
}

alias kconf='nvim "/Users/marlon/.config/kitty/kitty.conf"'

alias iservices='~/bin/industria_services.sh'
alias tdf='~/bin/tdf'

alias cpara='~/bin/create_para_folders.sh'
