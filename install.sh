#!/bin/zsh

current_dir=$(pwd)

link_config() {
    if [ $2 ]; then
        if [[ "$2" =~ ^[Oo]$ ]]; then
            echo "Overwrote $1"
            rm ~/$1
        else
            echo "Retaining"
            mv ~/$1 $1_old
        fi
    fi

    ln -s "$current_dir/$1" "$HOME/$1"
    echo "linked $1"
}

check_and_link() {
    if [[ -f ~/.$1 ]]; then
        read "choice?Found an existing $1 file [O]verwrite/[R]etain (defaults to retaining): "
        link_config $1 $choice
    else
        link_config $1
    fi
}

# Sym-Linking
check_and_link ".zshrc"
check_and_link ".vimrc"
check_and_link ".config/nvim"
check_and_link ".config/kitty"

echo "Done"
