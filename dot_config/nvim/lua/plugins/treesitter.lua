vim.api.nvim_create_autocmd({ 'Filetype' }, {
    callback = function(event)
        -- make sure nvim-treesitter is loaded
        local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')

        -- no nvim-treesitter, maybe fresh install
        if not ok then return end

        local parsers = require('nvim-treesitter.parsers')

        if not parsers[event.match] or not nvim_treesitter.install then return end

        local ft = vim.bo[event.buf].ft
        local lang = vim.treesitter.language.get_lang(ft)
        nvim_treesitter.install({ lang }):await(function(err)
            if err then
                vim.notify('Treesitter install error for ft: ' .. ft .. ' err: ' .. err)
                return
            end

            pcall(vim.treesitter.start, event.buf)
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end)
    end,
})

return {
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        event = 'VeryLazy',
        build = function()
            -- update parsers, if TSUpdate exists
            if vim.fn.exists(':TSUpdate') == 2 then vim.cmd('TSUpdate') end
        end,
        config = function(_, _)
            local ensure_installed = {
                'bash',
                'c',
                'css',
                'diff',
                'gitcommit',
                'html',
                'javascript',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'query',
                'vim',
                'vimdoc',
            }
            -- make sure nvim-treesitter can load
            local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')
            -- no nvim-treesitter, maybe fresh install
            if not ok then return end
            nvim_treesitter.install(ensure_installed)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function ()
            vim.api.nvim_set_hl(0, "TreesitterContext", { link = "CursorLine" })
            require'treesitter-context'.setup{
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                multiwindow = false, -- Enable multiwindow support.
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            }
        end,
    }
}

-- return {
--     "romus204/tree-sitter-manager.nvim",
--     dependencies = {}, -- tree-sitter CLI must be installed system-wide
--     config = function()
--         require("tree-sitter-manager").setup({
--             -- Optional: custom paths
--             -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
--             -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
--         })
--     end
-- }
