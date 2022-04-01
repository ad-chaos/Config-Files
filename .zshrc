# No Beeps please
unsetopt BEEP

# Enable vi mode
bindkey -v
export KEYTIMEOUT=1
autoload -Uz vcs_info
autoload -U colors && colors

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
zstyle ':vcs_info:git:*' formats "%{$fg[red]%}%m%u%c%{$fg[yellow]%} %F{214}%b%f"

# Change My prompt
PROMPT="%F{226}%2~%f \$vcs_info_msg_0_ %B%(?.%F{112}ζ%f.%F{196}ζ%f)%b "
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

#better tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

#use vim bindings for traversing through tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

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
alias gph="git push"
alias gpl="git pull upstream main"
alias gst="git status"
alias gc="git checkout"
alias gb="git branch"
alias ps="poetry shell"
alias c-="cd -"
alias c='clang++ -Wall -Wextra -Wshadow -fsanitize=undefined,address -D_GLIBCXX_DEBUG -g main.cpp'
alias b='cat test.txt | ./a.out'
alias g='c && echo done && b'

# Functions
cdev() { cd ~/git-repos/$1 }
_cdev() { _path_files -W ~/git-repos; }
compdef _cdev cdev

cdc() { cd ~/Coding-Adventures/$1 }
_cdc() { _path_files -W ~/Coding-Adventures }
compdef _cdc cdc

mcd() { mkdir $1 && cd $1 }
# Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Manim shell completion very slow 
# source ~/.manim.zsh

# Key bindings for fzf
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# PATH variable
export PATH="$HOME/neovim/bin:opt/homebrew/opt/fzf/bin:$HOME/Library/TinyTeX/bin/universal-darwin:$HOME/.poetry/bin:$PATH"

# Load zsh-syntax-highlighting; should be last.
source "/opt/homebrew/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
