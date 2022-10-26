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
setopt histignoredups

# https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!'
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%F{#fd5cba}%m%u%c%f%F{#ffffff} %f%F{#eefd7a}%b%f"

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
# TODO: This feels like a zsh bug
bindkey -v '^?' backward-delete-char

#Some QOL aliases

alias ls="exa --icons --group-directories-first -F"
alias la="exa --icons --group-directories-first -aF"
alias ll="exa --icons --group-directories-first -aF --long"

alias grep="grep --color=always"
alias icat="kitty +kitten icat"
alias diff="kitty +kitten diff"
alias pip="pip3"
alias python="python3"
alias gcm="git commit -m"
alias gst="git status"
alias gd="git diff"
alias gc="git checkout"
alias gb="git branch"
alias gcma="git commit -am"
alias ps="poetry shell"
alias c-="cd -"
alias cdr='cd "$(git rev-parse --show-toplevel || echo .)"'
alias cdcon="~/Config-Files/.config"
alias hg="kitty +kitten hyperlinked_grep"
alias ...="../../"
alias vimgolf='/opt/homebrew/lib/ruby/gems/3.1.0/bin/vimgolf'

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
        git add $1
    else
        git add .
    fi
}
# Project Euler
g() {
    clang++ -std=c++11 -g -fsanitize=undefined,address problem$1.cpp
    ./a.out
}

nup() {
    echo "Clearing old compilation of neovim"
    rm -rf neovim
    cdev neovim; rm -rf build

    echo "Compiling and Installing Neovim"
    cdev neovim; git pull > /dev/null; make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
    make install
}

fzf() { 
    file_dir=$(command fzf "$@")
    if [[ $? -eq 0 ]]; then
        nvim $file_dir
    fi
}

# Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings for fzf
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

#auto pairs
source "/Users/kiranrajpurohit/autopair.zsh"
autopair-init

# PATH variable
export PATH="$HOME/neovim/bin:opt/homebrew/opt/fzf/bin:$PATH"

export CPATH=/opt/homebrew/include/
export LIBRARY_PATH=/opt/homebrew/lib/

# default editor neovim please
export EDITOR=nvim
export VISUAL=nvim

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export FZF_DEFAULT_OPTS='--color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af72a2940or=fg+:#c0caf5,bg+:#2a2940,hl+:#7dcfff --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'
export FZF_DEFAULT_COMMAND="find . -type f -not -path '*/\.git/*' -print 2> /dev/null | cut -c 3-"
export FZF_ALT_C_COMMAND="find -L . -mindepth 1 -not -path '*/\.git/*' -type d -print 2> /dev/null | cut -c 3-"


# Load zsh-syntax-highlighting; should be last.
source "/opt/homebrew/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
