-- https://vi.stackexchange.com/a/2303
vim.cmd([[ command Unicode %s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g ]])
