local M = {}

local icons = require("nvim-web-devicons")
icons.set_up_highlights()

function M.file()
    local file_name = vim.fn.expand("%:t")
    local ext = vim.fn.expand("%:e")
    local icon, hl = icons.get_icon(file_name, ext, { default = "»" })
    return "%#" .. hl .. "#" .. icon .. "%*  " .. file_name
end

function M.diagnostic_status()
    local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local diag = ""

    if num_errors > 0 then
        diag = diag .. "%#error#  " .. num_errors .. "%* "
    end

    local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if num_warnings > 0 then
        -- "%#warningmsg#"
        diag = diag .. "%#warningmsg#  " .. num_warnings .. "%* "
    end
    return diag
end

function M.statusline()
    local parts = {
        [[%{%luaeval("require'statusline'.file()")%} %m%r]],
        [[%{get(b:,'gitsigns_status','')}]],
        "%=",
        "%#warningmsg#",
        "%{&ff!='unix' ? ' |'.&ff.'| ' : ''}",
        "%{(&fenc!='utf-8' && &fenc!='') ? ' |'.&fenc.'| ' : ''}",
        "%*",
        [[%{%luaeval("require'statusline'.diagnostic_status()")%}]],
        "[%L] %l:%c %P",
    }

    return table.concat(parts)
end

return M
