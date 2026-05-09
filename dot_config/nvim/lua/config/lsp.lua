require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
        "gopls",
        "clangd",
        "ts_ls",
        "emmet_language_server",
        "bashls",
        -- "eslint",
        -- "rust_analyzer",
        -- "omnisharp",
        -- "jdtls",
        -- "pylsp",
    }
}

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim"
                }
            };
            workspace = {
                library = {
                    "${3rd}/love2d/library",
                }
            };
        }
    }
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
    end,
})

local border = "rounded"
local opts = {
    max_width = 100,
    max_height = 14,
    border = border,
}

local hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function()
    return hover(opts)
end

local signature_help = vim.lsp.buf.signature_help
vim.lsp.buf.signature_help = function()
    return signature_help(opts)
end

vim.diagnostic.config({
    -- virtual_lines = true,
    virtual_text = {
        prefix = "⚑", -- "▎", "■", "x", "●"
    },
    severity_sort = true,
    float = {
        border = border,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = "󰋼 ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = "Error",
            [vim.diagnostic.severity.WARN] = "Error",
            [vim.diagnostic.severity.HINT] = "Hint",
            [vim.diagnostic.severity.INFO] = "Info",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
        },
    },
})

-- Show line diagnostics automatically when hovering
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
