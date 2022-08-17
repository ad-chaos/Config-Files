command Unicode %s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)
command -range -nargs=? Interleave <line1>,<line2>call InterleaveR(["="])
command -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
command DiffOrig vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis
command! -nargs=* -complete=customlist,v:lua.require'packer'.plugin_complete PackerSync lua require('packer').snapshot("PrevToSync") require('packer').sync(<f-args>)
