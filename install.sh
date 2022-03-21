#!/bin/zsh

current_dir=$(pwd)

# Neovim plugin manager
echo "Searching for Packer..."
if ! [[ -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]]; then
    echo "Packer not found: Installing"
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    echo "Packer Installed"
else
    echo "Found continuing install"
fi

link_config() {
    if [ $2 ]; then
        if [[ "$2" =~ ^[Oo]$ ]]; then
            echo "Deleted .$1"
            rm ~/.$1
        elif [[ "$2" =~ ^[Rr]$ ]]; then
            echo "Renamed and Retained"
            mv ~/.$1 $1_old
        else
            echo "Invalid Selection. Please Try again:"
            check_and_link $1
        fi
    fi

    ln -s $current_dir/.$1 ~/.$1
    echo "linked $1"
}

check_and_link() {
if [[ -f ~/.$1 ]]; then
    read "choice?Found an existing $1 config file [O]verwrite/[R]etain: "
    link_config $1 $choice
else
    link_config $1
fi
}
# Sym-Linking
check_and_link zshrc
check_and_link vimrc
check_and_link config/nvim
check_and_link config/kitty

echo "Installation Done"
echo "Please restart kitty and run PackerSync after opening Neovim"
