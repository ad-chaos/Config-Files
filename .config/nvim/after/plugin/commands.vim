command Unicode %s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g
command -range -nargs=? Interleave <line1>,<line2>call InterleaveR(<f-args>)
command -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
