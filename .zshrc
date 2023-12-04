# No Beeps please
unsetopt BEEP

# Enable vi mode
bindkey -v
export KEYTIMEOUT=1
autoload -Uz vcs_info
autoload edit-command-line
zle -N edit-command-line

# enable only git
zstyle ':vcs_info:*' enable git

# setup a hook that runs before every prompt.
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
setopt autocd
setopt append_history
setopt share_history
setopt histignorealldups
setopt extended_glob

# https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!'
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%F{#fd5cba}%m%u%c%f%F{#ffffff} %f%F{#eefd7a}%b%f"

# Change My prompt
PROMPT="%B%F{#6ffffd}%2~%f%b \$vcs_info_msg_0_ %B%(?.%F{#47cc5d}ζ%f.%F{196}ζ%f)%b "

# Add completions for brew installed tools
fpath+=/opt/homebrew/share/zsh/site-functions

#better tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# use vim bindings for traversing through tab complete menu
# https://thevaluable.dev/zsh-completion-guide-examples/
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect '^[' send-break
bindkey -M menuselect '+' accept-and-hold
bindkey -a '^ ' edit-command-line
bindkey -v '^?' backward-delete-char
bindkey -v '^K' up-line-or-history

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -a 'k' history-beginning-search-backward-end
bindkey -a 'j' history-beginning-search-forward-end


# https://github.com/zsh-vi-more/vi-motions/tree/dev
# https://www.reddit.com/r/zsh/comments/gktca7/comment/fqtw0gf
autoload -Uz surround

push-string() {
    local arg
    for arg; zle -U "$arg"
}

zle -N push-string

viopp-wrapper() {
    local key
    read -k 1 key
    if [[ $key = 's' ]]; then
        case $WIDGET in
            vi-change*) zle change-surround -w ;;
            vi-delete*) zle delete-surround -w ;;
            vi-yank*)   zle add-surround -w ;;
        esac
    else
        zle push-string $key
        sched +0 bindkey -M "$KEYMAP" "$KEYS" "$WIDGET"
        bindkey -M "$KEYMAP" "$KEYS" "${WIDGET%-wrapper}"
        zle ${WIDGET%-wrapper} -w
    fi
}

zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
zle -N vi-change-wrapper viopp-wrapper
zle -N vi-delete-wrapper viopp-wrapper
zle -N vi-yank-wrapper   viopp-wrapper
bindkey -M vicmd c vi-change-wrapper d vi-delete-wrapper y vi-yank-wrapper
bindkey -M visual S add-surround

autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $m $c select-bracketed
    done
done


#Some QOL aliases

alias ls="eza --icons --group-directories-first -F"
alias la="eza --icons --group-directories-first -aF"
alias ll="eza --icons --group-directories-first -aF --long"
alias tree="eza --icons --tree"

alias gimme="rg -F -uuu"
alias grep="rg"
alias icat="kitten icat"
alias diff="kitten diff"
alias pip="pip3.11"
alias python="python3.11"
alias gcm="git commit -m"
alias gst="git status"
alias gd="git diff"
alias gc="git checkout"
alias gb="git branch"
alias gcma="git commit -am"
alias oops="git commit --amend --no-edit"
alias c-="cd -"
alias cdr='cd "$(git rev-parse --show-toplevel || echo .)"'
alias cdcon="~/Config-Files/.config"
alias hg="kitty +kitten hyperlinked_grep"
alias ...="../../"
alias vimgolf='/opt/homebrew/lib/ruby/gems/3.1.0/bin/vimgolf'
alias ssh='kitten ssh'

# Zsh syntax highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#ccb521'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#22b587'

# Functions
cdev() { cd ~/git-repos/$1 }
_cdev() { _path_files -W ~/git-repos; }
compdef _cdev cdev

cdc() { cd ~/Coding-Adventures/$1 }
_cdc() { _path_files -W ~/Coding-Adventures }
compdef _cdc cdc

mcd() { mkdir $1 && cd $1 }

ga() {
    if [ $1 ]; then
        git add $@
    else
        git add .
    fi
}

nup() {
    local NO_CD_HOOK="ye_no_list"
    echo "Clearing old compilation of neovim"
    rm -rf neovim
    cdev neovim; rm -rf build

    echo "Compiling and Installing Neovim"
    cdev neovim; git pull --rebase origin master > /dev/null; make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
    make install
}

fzf-map() {
    local file_dir
    file_dir=$(command fzf --preview 'bat --color=always {}' --preview-window '~3' "$@" </dev/tty)
    if [[ $? -eq 0 ]]; then
        local program=
        case $file_dir in
            *.pdf | *.jpeg | *.png | *.jpg)
                program="open"
                ;;
            *)
                program="nvim"
                ;;
        esac
        $program $file_dir
    fi
}
zle -N fzf-map
bindkey -M viins '^O' fzf-map

chpwd() {
    if [[ $- =~ i && -z $NO_CD_HOOK ]]; then
        clear
        la
    fi
}

webm2mp4() {
    ffmpeg -i $1 -acodec aac -vcodec libx264 ${1%%.webm}.mp4
}

pair() {
    local dir="/tmp/pair"
    mkdir $dir && code $dir
}

swap() {
    mv $1 tmp && mv $2 $1 && mv tmp $2
}

nvim() {
    local nolsp="${argv[(Ie)--nolsp]}"
    if (( "$nolsp" != 0 )); then
        argv[$nolsp]=("--cmd" "let g:nolsp=1")
    fi

    local nocmp="${argv[(Ie)--nocmp]}"
    if (( "$nocmp" != 0)); then
        argv[$nocmp]=("--cmd" "let g:nocmp=1")
    fi

    command nvim "${argv[@]}"
}

# Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings for fzf
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

#auto pairs
source "$HOME/autopair.zsh"
autopair-init
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export CPATH=/opt/homebrew/include/
export LIBRARY_PATH=/opt/homebrew/lib/
export DYLD_LIBRARY_PATH=/opt/homebrew/lib/

# default editor neovim please
export EDITOR=nvim
export VISUAL=nvim

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export FZF_DEFAULT_OPTS='
--color=fg:#c0caf5,bg:#0d0e12,hl:#bb9af7
--color=fg+:#c0caf5,bg+:#0d0e12,hl+:#7dcfff
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff 
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix"
export FZF_ALT_C_COMMAND="find -L . -mindepth 1 -not -path '*/\.git/*' -type d -print 2> /dev/null | cut -c 3-"
export PYTHONBREAKPOINT='ipdb.set_trace'

# Load zsh-syntax-highlighting; should be last.
source "/opt/homebrew/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# bat -p $HOME/TODO.md
