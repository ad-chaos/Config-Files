" Use vim not vi
set nocompatible

" Using the vim-plugged package manager
call plug#begin('~/.vim/plugins')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim/killersheep'

call plug#end()

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number 

" Relative line numbers ftw
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" Use backspace because of course
set backspace=indent,eol,start

" Enable hidden buffers
set hidden

" Handle case selection
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Enable highlighting as I search
set hls

" Unbind some useless default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse for convinience
set mouse+=a

" Enable auto Indentation
set ai

" Enable file specific indentation
filetype plugin indent on

"show tab with four spaces width because Chris says so
set tabstop=8

" map leader to space
let mapleader=" "

" from r/vim
set softtabstop=4
" when indenting with '>' use four spaces
set shiftwidth=4

"on pressing tab insert 4 spaces
set expandtab

" change default ctrlp behaviour
let g:ctrlp_map = '<c-p>'
let g:ctrl_cmd = 'CtrlP'

" Make splitting more intuitive
set splitbelow splitright

" Change cursor depending on modes
" SI is Insert
" SR is Replace
" EI is Normal (Else)
"let &t_SI.="\e[6 q"
"let &t_SR.="\e[4 q"
"let &t_EI.="\e[2 q"
nnoremap <leader>w :w<CR>

colorscheme dracula

