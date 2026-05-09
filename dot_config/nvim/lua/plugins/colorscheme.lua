return {
    {
        "neanias/everforest-nvim",
        priority = 1000,
        enabled = true,
        config = function()
            require("everforest").setup({
                background = "soft",
                float_style = "bright",
                colours_override = function(palette)
                    palette.bg2 = "#333C43"
                end
            })
            vim.cmd.colorscheme "everforest"
        end,
    },
}
