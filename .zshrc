# No Beeps please
unsetopt BEEP

# Enable vi mode
bindkey -v
export KEYTIMEOUT=1

# Change My prompt
PS1="%F{190}%2d%f %B%(?.%F{112}ζ%f.%F{196}ζ%f)%b "
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
alias gph="git push upstream main"
alias gpl="git pull upstream main"
alias gst="git status"
alias gc="git checkout $1"
alias gb="git branch"
alias ps="poetry shell"
alias c-="cd -"

# Functions
cdev() { cd ~/git-repos/$1 }
_cdev() { _path_files -W ~/git-repos; }
compdef _cdev cdev

cdc() { cd ~/Coding-Adventures/$1 }
_cdc() { _path_files -W ~/Coding-Adventures }
compdef _cdc cdc

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
