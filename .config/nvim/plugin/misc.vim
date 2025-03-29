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

" This is slightly broken because in vim going from visual block to command mode
" is same as going from visual block to normal to command mode :/

let g:visb = v:false
augroup visual_block_select
    au ModeChanged [\x16]:* let g:visb = v:true
    au ModeChanged [c]:* let g:visb = v:false
augroup END
cnorea <expr> <silent> s g:visb ? {-> 's'..getcharstr(0)..'\%V'}() : 's'

augroup autosave
    au TextChanged,InsertLeave * if &modifiable && !empty(bufname()) && &buftype != 'nofile' | update | endif
augroup END

augroup update_status_line
    au LspNotify * redrawstatus
augroup END
