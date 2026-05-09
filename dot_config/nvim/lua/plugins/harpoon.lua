return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        config = function()
            local harpoon = require("harpoon")

            local toggle_opts = {
                title = " Harpoon ",
                title_pos = "center",
                border = "rounded",
                ui_width_ratio = 0.40,
            }

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<leader><Tab>", function() harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts) end)
            vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
        end,
    },
}
