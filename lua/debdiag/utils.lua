local M = {}

---@param callback fun()
---@param ms integer
function M.debounce(callback, ms)
    local timer = vim.uv.new_timer()

    return function(...)
        local args = { ... }

        timer:start(ms, 0, function()
            vim.schedule_wrap(callback)(unpack(args))
        end)
    end
end

return M
