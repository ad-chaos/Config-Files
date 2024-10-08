" nvo mappings
noremap <leader>P "0P
noremap <leader>p "0p
noremap <leader>d "_d

"  Terminal mode mappings
tnoremap ;q <C-\><C-n>
" Normal Mode mappings {{{
nnoremap <leader>o :e <C-R>=expand('%:p:h')..'/'<CR>
nnoremap <leader>a <cmd>NvimTreeToggle<CR>
nnoremap <leader>u g~w
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
nnoremap <M-k> <cmd>m -2<CR>
nnoremap <M-j> <cmd>m +1<CR>
nnoremap [c <cmd>cprevious<CR>
nnoremap ]c <cmd>cnext<CR>
nnoremap v <C-v>
nnoremap <C-v> v
nnoremap <C-,> gT
nnoremap <C-.> gt
nnoremap <S-Right> <cmd>tabmove +1<CR>
nnoremap <S-Left> <cmd>tabmove -1<CR>
nnoremap cb cvb
nnoremap db dvb
nnoremap 0 ^
nnoremap ^ 0
nnoremap ' `
nnoremap ` '
nnoremap zj mzyyP`z
nnoremap zk mzyyp`z
nnoremap <F5> <cmd>w<cr>
nmap <C-/> gcc
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
xmap <C-/> gc
" }}}

" Insert Mode Mappings
inoremap <M-k> <esc><cmd>m -2<CR>a
inoremap <M-j> <esc><cmd>m +1<CR>a
inoremap <expr> <c-y> (line('.')-1)->getline()->matchstr('\v\k*.', col('.')-1)

" Operator Pending Mode
onoremap <expr> iw ['<esc>', v:operator, 2*v:count1-1, 'iw']->join('')

lua<<EOF
vim.keymap.set({ 'n', 'i', 's' }, '<C-k>', function()
   if vim.snippet.jumpable(-1) then
     vim.snippet.jump(-1)
   end
end)

vim.keymap.set({ 'n', 'i', 's' }, '<C-j>', function()
   if vim.snippet.jumpable(1) then
     vim.snippet.jump(1)
   end
end)

vim.keymap.set('n', '<esc>', function()
    if vim.snippet.active() then
        vim.snippet.exit()
    end
end)
EOF
