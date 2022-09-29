local M = {}

function M.file_or_lsp_status()
    local messages = vim.lsp.util.get_progress_messages()

    if vim.tbl_isempty(messages) or messages.done then
        return vim.fn.expand "%:."
    end

    local percentage
    local result = {}
    for _, msg in pairs(messages) do
        if msg.message then
            table.insert(result, msg.title .. ": " .. msg.message)
        else
            table.insert(result, msg.title)
        end
        if msg.percentage then
            percentage = math.max(percentage or 0, msg.percentage)
        end
    end
    if percentage then
        return string.format("%03d: %s", percentage, table.concat(result, ", "))
    else
        return table.concat(result, ", ")
    end
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
        [[» %{luaeval("require'statusline'.file_or_lsp_status()")} %m%r%=]],
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
