let g:mapleader = " "
let g:maplocalleader = "\\"
" nvo mappings
noremap <leader>P "0P
noremap <leader>p "0p

"  Terminal mode mappings
tnoremap ;q <C-\><C-n>
" Normal Mode mappings {{{
nnoremap <leader>o :e <C-R>=expand('%:p:h')..'/'<CR>
nnoremap <leader>fl <cmd>Telescope find_files hidden=true<CR>
nnoremap <leader>gf <cmd>Telescope git_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <leader>gb <cmd>Gitsigns blame_line<CR>
nnoremap <leader>rr <cmd>Gitsigns reset_hunk<CR>
nnoremap <leader>re <cmd>Gitsigns reset_buffer<CR>
nnoremap ]g <cmd>Gitsigns next_hunk<CR>
nnoremap [g <cmd>Gitsigns prev_hunk<CR>
nnoremap <leader>a <cmd>Lex 30<CR>
nnoremap <leader>u g~w
nnoremap <leader>fm <cmd>Neoformat<CR>
nnoremap <silent> <leader>w <cmd>silent w<CR>
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
nnoremap cb cvb
nnoremap db dvb
" }}}
" Visual Mode mappings {{{
xnoremap <leader>i g<C-a>
xnoremap <leader>s r0gvg<C-a>
xnoremap <leader>y "+y
xnoremap <M-j> :m '>+1<CR>gv
xnoremap <M-k> :m '<-2<CR>gv
xnoremap > >gv
xnoremap < <gv
xnoremap <C-l> lOhO
xnoremap <C-h> hOlO
xnoremap <C-j> joko
xnoremap <C-k> kojo
" }}}
" Insert Mode Mappings
inoremap <M-k> <esc><cmd>m -2<CR>a
inoremap <M-j> <esc><cmd>m +1<CR>a
