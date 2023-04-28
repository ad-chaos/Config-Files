let mapleader=" "
let g:netrw_banner=0
filetype plugin indent on
set nocompatible

" Autocommands {{{
augroup autosave
    au TextChanged,InsertLeave * if &modifiable && !empty(bufname()) | update | endif
augroup END
" }}}

" Options {{{
set shortmess+=I
set laststatus=2
set backspace=indent,eol,start
set hidden
set ignorecase
set smartcase
set incsearch
set hls
set noerrorbells visualbell t_vb=
set mouse+=a
set ai
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set splitbelow splitright
set nrformats+=alpha
set autochdir
set foldmethod=marker
set formatoptions+=/ro
set undofile
set undodir=~/.vim/undo
set cpoptions-=_
set gdefault
set autoread
set signcolumn=yes
" }}}

" Mappings {{{
" nvo mode
noremap <leader>p "0p
noremap <leader>P "0P

" Normal Mode {{{
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

nnoremap <leader>w :w<CR>
nnoremap Y y$
nnoremap <leader>a <cmd>Lex 30<CR>
nnoremap <leader>u g~w
nnoremap <leader>fm <cmd>Neoformat<CR>
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
nnoremap <leader>yy "+yy
nnoremap <leader>- <C-^>
nnoremap <Up> <cmd>resize -4<CR>
nnoremap <Down> <cmd>resize +4<CR>
nnoremap <Left> <cmd>vertical resize -4<CR>
nnoremap <Right> <cmd>vertical resize +4<CR>
nnoremap <C-n> <cmd>noh<CR>
nnoremap vs <cmd>vs<CR>
nnoremap gJ @="Jx"<CR>
nnoremap gn ngn<esc>
nnoremap <M-k> <cmd>m -2<CR>
nnoremap <M-j> <cmd>m +1<CR>
nnoremap [c <cmd>cprevious<CR>
nnoremap ]c <cmd>cnext<CR>
nnoremap v <C-v>
nnoremap <C-v> v
nnoremap <C-,> gT
nnoremap <C-.> gt
nnoremap <S-CR> S<CR><ESC>
nnoremap <C-CR> o<ESC>
" }}}

" Visual Mode {{{
xnoremap <leader>i g<C-a>
xnoremap <leader>y "+y
xnoremap <M-j> :m '>+1<CR>gv
xnoremap <M-k> :m '<-2<CR>gv
xnoremap p "_dP
xnoremap // y/\\V<C-R>=escape(@\",'/')<CR><CR>
xnoremap > >gv
xnoremap < <gv
xnoremap <C-l> lOhO
xnoremap <C-h> hOlO
xnoremap <C-j> joko
xnoremap <C-k> kojo
" }}}

" Insert Mode {{{
inoremap <M-k> <esc><cmd>m -2<CR>a
inoremap <M-j> <esc><cmd>m +1<CR>a
" }}}
