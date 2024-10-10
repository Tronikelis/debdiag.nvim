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

    local diagnostics_show = utils.debounce(function()
        vim.diagnostic.enable(true)
    end, M.config.ms)

    vim.api.nvim_create_autocmd(M.config.autocmd, {
        callback = function()
            vim.diagnostic.enable(false, { bufnr = 0 })
            diagnostics_show()
        end,
    })

    if M.config.enable_leave_insert then
        vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
                vim.diagnostic.enable(true)
            end,
        })
    end
end

return M
