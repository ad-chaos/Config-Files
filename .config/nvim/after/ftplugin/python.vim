setlocal foldmethod=indent
setlocal formatoptions+=ro
autocmd BufWritePost <buffer> !black <afile>
