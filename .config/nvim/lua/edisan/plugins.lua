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

    {
        "nvim-treesitter/nvim-treesitter",
        config = function() require('edisan.plugins.treesitter') end
    },

    {
        "nvim-lualine/lualine.nvim",
        config = function() require('edisan.plugins.line') end
    },

    -- completion
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},

    -- snippets
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", 
        -- install jsregexp (optional!).
        -- build = "make install_jsregexp"
    },

    -- LSP
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
}


require("lazy").setup(plugins, opts)
