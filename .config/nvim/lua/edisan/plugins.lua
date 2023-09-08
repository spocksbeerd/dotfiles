local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

opts = {}


plugins = {
    { 
        "ellisonleao/gruvbox.nvim", 
        priority = 1000,
        config = function() require('edisan.plugins.gruvbox') end
    },
--    { 
--        "catppuccin/nvim",
--        priority = 1000,
--        config = function() require('edisan.plugins.catppuccin') end
--    },

    "nvim-treesitter/nvim-treesitter",
    {
        "nvim-lualine/lualine.nvim",
        config = function() require('edisan.plugins.line') end
    },
}


require("lazy").setup(plugins, opts)
