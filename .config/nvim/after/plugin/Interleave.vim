function! InterleaveR(...) range
    if a:0 != 0
        let @t=a:1
        let @m="'bj:m 'a
    else
        let @m="'bj:m 'a
    endif

    if a:firstline == 1
        normal ggO
    endif
    call cursor(a:firstline-1, 0)
    normal mb
    let cnt = a:lastline - a:firstline + 1
    execute "normal " . cnt . "@m"
    normal "_dd
endfunction