# No Beeps please
unsetopt BEEP

# Enable vi mode
bindkey -v
export KEYTIMEOUT=1

export HISTSIZE=10000000
export SAVESIZE=10000000
export HISTFILE=~/.zhistory
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt inc_append_history

setopt prompt_subst
setopt autocd
setopt append_history
setopt share_history
setopt extended_glob

# https://anishathalye.com/an-asynchronous-shell-prompt/
function git_info() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]] then
        return
    fi

    local BRANCH
    BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null)
    if [[ $? -gt 0 ]] then
        BRANCH=$(git name-rev --name-only --no-undefined --always HEAD)
        BRANCH=$BRANCH" ($(git rev-parse --short HEAD))"
    fi

    local CHANGES
    CHANGES=$(git status --porcelain=v2 | cut -d ' ' -f 1,2 | git-status-prompt)
    echo "%F{#fd5cba}$CHANGES%f%F{#ffffff} %f%F{#eefd7a}$BRANCH%f"
}

ASYNC_PROC=0
function async_vcs_update() {
    function async() {
        printf "%s" "$(git_info)" > "${HOME}/.zsh_vcs_prompt"
        kill -s USR1 $$
    }

    if [[ "${ASYNC_PROC}" != 0 ]]; then
        kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || :
    fi
    async &!
    ASYNC_PROC=$!
}

function TRAPUSR1() {
    local prompt_parts
    prompt_parts=("${(s: :)PROMPT}")

    local git_info
    git_info="$(cat ${HOME}/.zsh_vcs_prompt)"

    local invenv=""
    if [[ ${prompt_parts[1]} =~ ".*(venv).*" ]] then
        invenv="${prompt_parts[1]}"
        prompt_parts=("${prompt_parts[@]:1}")
    fi

    if [[ $#prompt_parts -eq 3 ]] then
        prompt_parts[1]=("$prompt_parts[1]" "$git_info")
    else
        local svcs=${prompt_parts[(I)*]} evcs=${#prompt_parts}
        prompt_parts[svcs,evcs-2]=("$git_info")
    fi

    if [[ -n $invenv ]] then
        prompt_parts=($invenv $prompt_parts)
    fi

    PROMPT="${(@j: :)prompt_parts:#} "

    ASYNC_PROC=0
    zle && zle reset-prompt
}

precmd_functions+=async_vcs_update

# Change My prompt
PROMPT="%B%F{#6ffffd}%2~%f%b %B%(?.%F{#47cc5d}ζ%f.%F{196}ζ%f)%b "

# Add completions for brew installed tools
fpath+=(/opt/homebrew/share/zsh/site-functions $HOME/.zfunc)

# better tab completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)


# use vim bindings for traversing through tab complete menu
# https://thevaluable.dev/zsh-completion-guide-examples/
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect '^[' send-break
bindkey -M menuselect '+' accept-and-hold

autoload edit-command-line
zle -N edit-command-line
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
    for arg; zle -U $arg
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
        sched +0 bindkey -M $KEYMAP $KEYS $WIDGET
        bindkey -M $KEYMAP $KEYS ${WIDGET%-wrapper}
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

change-prompt() {
    PROMPT="%B%F{#6ffffd}$1%b %F{#47cc5d}ζ%f "
}


#Some QOL aliases

alias ls="eza --icons --group-directories-first -F=always"
alias la="eza --icons --group-directories-first -a -F=always"
alias ll="eza --icons --group-directories-first -a -F=always --long"
alias tree="eza --icons --tree"

alias gimme="rg -F -uuu"
alias grep="rg"
alias icat="kitten icat"
alias diff="kitten diff"
alias gcm="git commit -m"
alias gst="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gc="git checkout"
alias gcf="git checkout --force"
alias gb="git branch"
alias gcma="git commit -am"
alias oops="git commit --amend --no-edit"
alias grs="git restore -p ."
alias c-="cd -"
alias cdr='cd "$(git rev-parse --show-toplevel || echo .)"'
alias cdcon="$HOME/git-repos/ad-chaos/Config-Files/.config"
alias hg="kitty +kitten hyperlinked_grep"
alias ...="../../"
alias vimgolf='/opt/homebrew/lib/ruby/gems/3.1.0/bin/vimgolf'
alias ssh='kitten ssh'
alias broadcast="kitty +kitten broadcast -t state:active"

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
compdef _directories mcd

ga() {
    if [ $1 ]; then
        git add $@
    else
        git add .
    fi
}
compdef _git ga=git-add

nup() {
    local NO_CD_HOOK="ye_no_list"
    rm -rf build
    make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
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
    mv $1 __tmp && mv $2 $1 && mv __tmp $2
}

nvim() {
    local nolsp=${argv[(Ie)--nolsp]}
    if (( $nolsp != 0 )); then
        argv[$nolsp]=("--cmd" "let g:nolsp=1")
    fi

    local nocmp=${argv[(Ie)--nocmp]}
    if (( $nocmp != 0)); then
        argv[$nocmp]=("--cmd" "let g:nocmp=1")
    fi

    local nots=${argv[(Ie)--nots]}
    if (( $nots != 0)); then
        argv[$nots]=("--cmd" "let g:nots=1")
    fi

    command nvim ${argv[@]}
}

load_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

build-kitty() {
    if [ -d .git ] && [ $(basename `git config --local --get remote.origin.url`) = "kitty.git" ]; then
        cp -r ../kitty-icon/build/neue_azure.iconset/* logo/kitty.iconset/
        make
        make docs
        make app
        git restore logo/
    else
        echo "Need to be in kitty checkout"
        return 1
    fi
}

need-brewlibs() {
    if [ $1 ]; then
        export CPATH=/opt/homebrew/include/
        export LIBRARY_PATH=/opt/homebrew/lib/
        export DYLD_LIBRARY_PATH=/opt/homebrew/lib/
    else
        unset CPATH
        unset LIBRARY_PATH
        unset DYLD_LIBRARY_PATH
    fi
}

tol() {
    tar -cv --lzma -f "$1.tar.xz" "$1"
}

untol() {
    tar xvzf "$1"
}

# Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings for fzf
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

#auto pairs
source "$HOME/autopair.zsh"
autopair-init


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# default editor neovim please
export EDITOR=nvim
export VISUAL=nvim

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export FZF_DEFAULT_OPTS='
--color=fg:#c0caf5,bg:#0d0e12,hl:#bb9af7
--color=fg+:#c0caf5,bg+:#0d0e12,hl+:#7dcfff
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --follow"
export FZF_ALT_C_COMMAND="find -L . -mindepth 1 -not -path '*/\.git/*' -type d -print 2> /dev/null | cut -c 3-"
export PYTHONBREAKPOINT='ipdb.set_trace'

# Load zsh-syntax-highlighting; should be last.
source "/opt/homebrew/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# bat -p $HOME/TODO.md
