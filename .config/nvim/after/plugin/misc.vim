function! InterleaveR(seperator) range
    if empty(a:seperator)
        let @m="'bj:m 'a
    else
        let @t=a:seperator
        let @m="'bj:m 'a
    endif

    if a:firstline == 1
        normal ggO
    endif
    call cursor(a:firstline-1, 0)
    normal mb
    let cnt = a:lastline - a:firstline + 1
    silent execute "normal " . cnt . "@m"
    normal "_dd
endfunction

function! TabMessage(cmd)
    redir => output
    silent execute a:cmd
    redir END
    if empty(output)
        echoerr "No output"
    else
        tabnew
        setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
        silent execute "file [" . fullcommand(a:cmd) . " Output]"
        silent put=output
    endif
endfunction

" abcd
"
augroup undercurls
    au!
    au ColorScheme dracula hi SpellBad   gui=undercurl 
                       \ | hi SpellCap   gui=undercurl
                       \ | hi SpellRare  gui=undercurl
                       \ | hi SpellLocal gui=undercurl
augroup END