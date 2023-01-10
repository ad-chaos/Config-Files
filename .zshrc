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
bindkey -v '^?' backward-delete-char

#Some QOL aliases

alias ls="exa --icons --group-directories-first -F"
alias la="exa --icons --group-directories-first -aF"
alias ll="exa --icons --group-directories-first -aF --long"

alias gimme="rg -F -uuu"
alias grep="grep --color=always"
alias icat="kitty +kitten icat"
alias diff="kitty +kitten diff"
alias pip="pip3.10"
alias python="python3.10"
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
alias find='command find . -name'
alias findf='command find . -type f -name'

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
    cdev neovim; git pull > /dev/null; make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
    make install
}

fzf-map() {
    local file_dir
    file_dir=$(command fzf "$@" </dev/tty)
    if [[ $? -eq 0 ]]; then
        local program="nvim"
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

# Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings for fzf
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

#auto pairs
source "$HOME/autopair.zsh"
autopair-init

# PATH variable
export PATH="$HOME/neovim/bin:opt/homebrew/opt/fzf/bin:$PATH"

export CPATH=/opt/homebrew/include/
export LIBRARY_PATH=/opt/homebrew/lib/

# default editor neovim please
export EDITOR=nvim
export VISUAL=nvim

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
export FZF_DEFAULT_COMMAND="find . -type f -not -path '*/\.git/*' -print 2> /dev/null | cut -c 3-"
export FZF_ALT_C_COMMAND="find -L . -mindepth 1 -not -path '*/\.git/*' -type d -print 2> /dev/null | cut -c 3-"
export PYTHONBREAKPOINT='ipdb.set_trace'


# Load zsh-syntax-highlighting; should be last.
source "/opt/homebrew/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
