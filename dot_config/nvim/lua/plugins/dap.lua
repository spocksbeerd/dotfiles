return {
    {
        "igorlfs/nvim-dap-view",
        dependencies = {
            "mfussenegger/nvim-dap",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
        },
        -- lazy = false,
        event = "VeryLazy",
        config = function ()
            require("nvim-dap-virtual-text").setup()
            require("dap-go").setup()

            local dap = require("dap")
            vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
            vim.keymap.set("n", "<F1>", dap.continue)
            vim.keymap.set("n", "<F2>", dap.step_into)
            vim.keymap.set("n", "<F3>", dap.step_over)
            vim.keymap.set("n", "<F4>", dap.step_out)
            vim.keymap.set("n", "<F5>", dap.step_back)
            vim.keymap.set("n", "<F12>", dap.restart)

            require("dap-view").setup({
                winbar = {
                    controls = {
                        enabled = true,
                    },
                },
                help = {
                    border = nil,
                },
                -- Requires neovim 0.12+
                virtual_text = {
                    enabled = true,
                },
                -- Controls how to jump when selecting a breakpoint or navigating the stack
                -- Comma separated list, like the built-in 'switchbuf'. See :help 'switchbuf'
                -- Only a subset of the options is available: newtab, useopen, usetab and uselast
                -- Can also be a function that takes the current winnr and the destination bufnr
                -- If a function, should return the winnr of the destination window
                switchbuf = "usetab,uselast",
                -- Auto open when a session is started and auto close when all sessions finish
                -- Alternatively, can be a string:
                -- - "keep_terminal": as above, but keeps the terminal when the session finishes
                -- - "open_term": open the terminal when starting a new session, nothing else
                auto_toggle = true,
                -- Reopen dapview when switching to a different tab
                -- Can also be a function to dynamically choose when to follow, by returning a boolean
                -- If a function, receives the name of the adapter for the current session as an argument
                follow_tab = false,
            })
        end,
    },

    -- nvim-dap-ui
    -- {
    --     "rcarriga/nvim-dap-ui",
    --     dependencies = {
    --         "mfussenegger/nvim-dap",
    --         "leoluz/nvim-dap-go",
    --         "theHamsta/nvim-dap-virtual-text",
    --         "nvim-neotest/nvim-nio",
    --     },
    --     event = "VeryLazy",
    --     config = function ()
    --         local dap = require("dap")
    --         local dap_go = require("dap-go")
    --         local ui = require("dapui")
    --
    --         dap_go.setup()
    --         ui.setup()
    --         require("nvim-dap-virtual-text").setup()
    --
    --         vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
    --         vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
    --
    --         -- Eval var under cursor
    --         vim.keymap.set("n", "<space>?", function()
    --             require("dapui").eval(nil, { enter = true })
    --         end)
    --
    --         vim.keymap.set("n", "<F1>", dap.continue)
    --         vim.keymap.set("n", "<F2>", dap.step_into)
    --         vim.keymap.set("n", "<F3>", dap.step_over)
    --         vim.keymap.set("n", "<F4>", dap.step_out)
    --         vim.keymap.set("n", "<F5>", dap.step_back)
    --         vim.keymap.set("n", "<F12>", dap.restart)
    --
    --         dap.listeners.before.attach.dapui_config = function()
    --             ui.open()
    --         end
    --         dap.listeners.before.launch.dapui_config = function()
    --             ui.open()
    --         end
    --         dap.listeners.before.event_terminated.dapui_config = function()
    --             ui.close()
    --         end
    --         dap.listeners.before.event_exited.dapui_config = function()
    --             ui.close()
    --         end
    --     end
    -- }
}
