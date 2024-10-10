# cleardig.nvim

Debounced diagnostics in insert mode

## Philosophy

Do you like ?

```lua
vim.diagnostic.config({
    update_in_insert = true,
})
```
Me too, but it quickly gets out of hand with many messages when trying to write code,
especially with lsps that report syntax errors

What if we could disable them temporarily when writing, and then enable them after we're done?

https://github.com/user-attachments/assets/894742e1-2626-466e-aa92-4e1c3dd067a7


## Config

```lua
require("cleardig").setup({
    --- the command which will disable and enable the diagnostics after debounce
    autocmd = "TextChangedI",
    --- enable diagnostics after leaving insert mode
    enable_leave_insert = true,
    --- debounce timer
    ms = 1000,
})
```


