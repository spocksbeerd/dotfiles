-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "highlight selection on yank",
    callback = function()
        vim.highlight.on_yank({ timeout = 200, visual = true })
    end,
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("no_auto_comment", {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
    callback = function()
        vim.opt_local.cursorline = true
    end,
})

-- show cursorline only in active window disable
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = "active_cursorline",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})
