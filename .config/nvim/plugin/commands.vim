command Unicode %s/\v\\u(\x{4})/\=nr2char('0x'.submatch(1),1)
command -range -nargs=? Interleave <line1>,<line2>call InterleaveR(<f-args>)
command -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
command WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
