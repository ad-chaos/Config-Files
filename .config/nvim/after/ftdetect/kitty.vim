autocmd! BufNewFile,BufRead kitty.conf,*/kitty/*.conf setl ft=kitty
autocmd! BufNewFile,BufRead */kitty/*.session setl ft=kitty-session
set comments+=b:#,b:#\:
