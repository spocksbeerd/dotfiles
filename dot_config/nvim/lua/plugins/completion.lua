return {
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        event = "VeryLazy",
        enabled = true,
        opts = {
            keymap = {
                preset = 'none',
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide', 'fallback' },
                ['<CR>'] = { 'select_and_accept', 'fallback' },

                ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
                ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },

                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

                ['<Tab>'] = { 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

                -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = { documentation = { auto_show = true } },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        event = "VeryLazy",
        enabled = false,
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load {
                exclude = { "css" },
            }
        end,
    },
}
