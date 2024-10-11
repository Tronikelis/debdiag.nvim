local utils = require("debdiag.utils")

local M = {
    config = {
        --- the command which will disable and enable the diagnostics after debounce
        autocmd = "TextChangedI",
        --- enable diagnostics after leaving insert mode
        enable_leave_insert = true,
        --- debounce timer
        ms = 600,
    },
}

function M.setup(config)
    config = config or {}
    M.config = vim.tbl_deep_extend("force", M.config, config)

    local diagnostics_show = utils.debounce(function(buf)
        vim.diagnostic.enable(true, { bufnr = buf })
    end, M.config.ms)

    vim.api.nvim_create_autocmd(M.config.autocmd, {
        callback = function()
            local buf = vim.api.nvim_get_current_buf()
            vim.diagnostic.enable(false, { bufnr = buf })
            diagnostics_show(buf)
        end,
    })

    if M.config.enable_leave_insert then
        vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
                vim.diagnostic.enable(true, { bufnr = 0 })
            end,
        })
    end
end

return M
