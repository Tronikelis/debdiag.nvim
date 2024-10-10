local M = {}

---@param callback fun
---@param ms integer
function M.setTimeout(callback, ms)
    callback = vim.schedule_wrap(callback)

    local timer = vim.uv.new_timer()
    timer:start(ms, 0, function()
        timer:stop()
        timer:close()
        callback()
    end)

    return timer
end

---@param callback fun()
---@param ms integer
function M.debounce(callback, ms)
    callback = vim.schedule_wrap(callback)
    local timer = nil

    return function(...)
        local args = { ... }

        local cb = function()
            callback(unpack(args))
        end

        if timer then
            pcall(timer.stop, timer)
            pcall(timer.close, timer)
        end

        timer = M.setTimeout(cb, ms)
    end
end

return M
