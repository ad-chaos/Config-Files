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

# setup a hook that runs before every ptompt. 
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# 
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
RPS1='-- INSERT --'

# Show what mode I am in
function zle-keymap-select {
     # Block cursor when normal mode
     if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
    
     # Beam cursor when insert mode
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi

    #sees keymap state and changes text displayes accordingly
    RPS1=""${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --} 
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-keymap-select

function zle-line-init() {
    zle -K viins
    echo -ne '\e[6 q'
}

zle -N zle-line-init

echo -ne '\e[6 q'
preexec() { echo -ne '\e[6 q'; }

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
bindkey -M menuselect 'k' vi-history-search-backward
bindkey -M menuselect 'j' vi-history-search-forward
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect '^[' send-break
bindkey -M menuselect '+' accept-and-hold
bindkey -M vicmd '^ ' edit-command-line

#Some magic for C-c error handling
function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

#Some QOL aliases

alias ls="exa --icons --group-directories-first -F"
alias la="exa --icons --group-directories-first -aF"
alias ll="exa --icons --group-directories-first -aF --long"

alias grep="grep --color=always"
alias icat="kitty +kitten icat"
alias diff="kitty +kitten diff"
alias cdm="cd ~/Documents/Manim"
alias pip="pip3"
alias python="python3"
alias gcm="git commit -m"
alias ga="git add ."
alias gst="git status"
alias gd="git diff"
alias gc="git checkout"
alias gb="git branch"
alias ps="poetry shell"
alias c-="cd -"
alias c='clang++ -std=c++11 -Wall -Wextra -Wshadow -fsanitize=undefined,address -D_GLIBCXX_DEBUG -g main.cpp'
alias b='cat test.txt | ./a.out'
alias g='c && echo done && b'
alias cdr='cd "$(git rev-parse --show-toplevel || echo .)"'

# Zsh syntax highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#ccb521'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#22b587'

ZSH_HIGHLIGHT_DIRS_BLACKLIST+=(~/Documents)
# Functions
cdev() { cd ~/git-repos/$1 }
_cdev() { _path_files -W ~/git-repos; }
compdef _cdev cdev

cdc() { cd ~/Coding-Adventures/$1 }
_cdc() { _path_files -W ~/Coding-Adventures }
compdef _cdc cdc

mcd() { mkdir $1 && cd $1 }

rotate_vid() {
    if [ $2 ]; then
        ffmpeg -i $1 -vf "transpose=1" $2
    else
        ffmpeg -i $1 -vf "transpose=1" $1_rot.mp4
    fi
}


# Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings for fzf
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# PATH variable
export PATH="$HOME/neovim/bin:opt/homebrew/opt/fzf/bin:$HOME/Library/TinyTeX/bin/universal-darwin:$PATH"
#:$HOME/.poetry/bin:$PATH"
export CPATH=/opt/homebrew/include/
export LIBRARY_PATH=/opt/homebrew/lib/

# Load zsh-syntax-highlighting; should be last.
source "/opt/homebrew/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
