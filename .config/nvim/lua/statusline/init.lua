local M = {}

M.file_icons = require "statusline.icons"

function M.file()
    local file_name = vim.fn.expand "%:t"
    local file_ext_icon = M.file_icons[vim.fn.expand "%:e"] or M.file_icons[file_name] or "»"
    return file_ext_icon .. " " .. file_name
end

function M.diagnostic_status()
    local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })

    if num_errors > 0 then
        return " ❗ " .. num_errors .. " "
    end

    local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if num_warnings > 0 then
        return " ⚠️  " .. num_warnings .. " "
    end
    return ""
end

function M.statusline()
    local parts = {
        [[%{luaeval("require'statusline'.file()")} %m%r]],
        [[%{get(b:,'gitsigns_status','')}%=]],
        "%#warningmsg#",
        "%{&ff!='unix' ? '['.&ff.'] ' : ''}",
        "%*",
        "%#warningmsg#",
        "%{(&fenc!='utf-8' && &fenc!='') ? '['.&fenc.'] ' : ''}",
        "%*",
        [[%{luaeval("require'statusline'.diagnostic_status()")}]],
    }

    return table.concat(parts)
end

return M
