local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jk", "<Esc>", opts)
vim.keymap.set("n", "<leader>e", ":Ex<CR>", opts)

vim.keymap.set("n", "<C-Up>",    ":resize +1<CR>", opts)
vim.keymap.set("n", "<C-Down>",  ":resize -1<CR>", opts)
vim.keymap.set("n", "<C-Left>",  ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

vim.keymap.set("x", "p", '"_dP', opts)
vim.keymap.set("x", "P", '"_dP', opts)

vim.keymap.set("n", "<A-Esc>", function()
    local current_buf = vim.api.nvim_get_current_buf()
    local deleted = 0
    local unsaved_bufs = {}

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and buf ~= current_buf and vim.api.nvim_buf_get_option(buf, "buflisted") then
            if vim.api.nvim_buf_get_option(buf, "modified") then
                table.insert(unsaved_bufs, {
                    num = buf,
                    name = vim.api.nvim_buf_get_name(buf)
                })
            else
                vim.api.nvim_buf_delete(buf, {})
                deleted = deleted + 1
            end
        end
    end

    local msg = "Deleted " .. deleted .. " buffer" .. (deleted ~= 1 and "s" or "")
    if #unsaved_bufs > 0 then
        msg = msg .. ", kept " .. #unsaved_bufs .. " with unsaved changes:\n"
        for i, buf in ipairs(unsaved_bufs) do
            msg = msg .. i .. ". " .. buf.name .. "\n"
        end
    end
    print(msg)
end, opts)
