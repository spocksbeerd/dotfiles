require("gruvbox").setup({
    transparent_mode = true,
    italic = {
        strings = false,
        comments = true,
        operators = false,
        folds = false,
    },
    bold = false,
})

vim.cmd.colorscheme "gruvbox"
