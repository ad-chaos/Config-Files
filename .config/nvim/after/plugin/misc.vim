function! InterleaveR(seperator="") range
    if empty(a:seperator)
        let @m="'bj:m 'ajma"
    else
        let @t=a:seperator
        let @m="'bj:m 'ak$\"tpgJjma"
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

function! Evaluate()
    normal dab
    call getreg()->eval()->string()->setreg("")
    normal p
endfunction

nnoremap <leader>e <cmd>call Evaluate()<CR>

let g:visb = v:false
au ModeChanged [\x16]:* let g:visb = v:true
au ModeChanged c:* let g:visb = v:false
cnorea <expr> <silent> s g:visb ? {-> 's'.getcharstr(0).'\%V'}() : 's'
