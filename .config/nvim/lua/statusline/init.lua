local M = {}

function M.file_or_lsp_status()
    -- Neovim keeps the messages send from the language server in a buffer and
    -- get_progress_messages polls the messages
    local messages = vim.lsp.util.get_progress_messages()

    -- If neovim isn't in normal mode, or if there are no messages from the
    -- language server display the file name
    if vim.tbl_isempty(messages) or messages.done then
        return vim.fn.expand "%:."
    end

    local percentage
    local result = {}
    -- Messages can have a `title`, `message` and `percentage` property
    -- The logic here renders all messages into a stringle string
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
    -- count the number of diagnostics with severity warning
    local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    -- If there are any errors only show the error count, don't include the number of warnings
    if num_errors > 0 then
        return " ❗ " .. num_errors .. " "
    end
    -- Otherwise show amount of warnings, or nothing if there aren't any.
    local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if num_warnings > 0 then
        return " ⚠️  " .. num_warnings .. " "
    end
    return ""
end

function M.statusline()
    local parts = {
        [[» %{luaeval("require'statusline'.file_or_lsp_status()")} %m%r%=]],

        -- New things below:
        -- %# starts a highlight group; Another # indicates the end of the highlight group name
        -- This causes the next content to display in colors (depending on the color scheme)
        "%#warningmsg#",

        -- vimL expressions can be placed into `%{ ... }` blocks
        -- The expression uses a conditional (ternary) operator: <condition> ? <truthy> : <falsy>
        -- If the current file format is not 'unix', display it surrounded by [], otherwise show nothing
        "%{&ff!='unix' ? '['.&ff.'] ' : ''}",

        -- Resets the highlight group
        "%*",

        "%#warningmsg#",
        -- Same as before with the file format, except for the file encoding and checking for `utf-8`
        "%{(&fenc!='utf-8' && &fenc!='') ? '['.&fenc.'] ' : ''}",
        "%*",
        [[%{luaeval("require'statusline'.diagnostic_status()")}]],
    }
    -- Parts aren't empty, see remainder of the post
    -- Instead of defining one long string I use the parts/table.concat pattern
    -- to split up the full definition into smaller more readable parts.
    -- It would also allow to add parts based on conditions
    return table.concat(parts)
end

return M
