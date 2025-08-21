vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
      dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {"nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}
  end,},
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
},
 {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
}

require("lazy").setup(plugins, opts)
local opts = {}

require('lualine').setup {
  options = {
    icons_enabled = true,
  },
  sections = {
    lualine_a = {
      {
        'filename',
        path = 1,
      }
    } }
}

-- require("lazy").setup({{
--    "nvim-treesitter/nvim-treesitter",
--     build = ":TSUpdate",
--     config = function () 
--       local configs = require("nvim-treesitter.configs")
-- 
--       configs.setup({
--           ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "python" },
--           sync_install = false,
--           highlight = { enable = true },
--           indent = { enable = true },  
--         })
--     end
--  }})

local configs = require("nvim-treesitter.configs")
configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "python" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')

local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files hidden=true<cr>', {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

require("catppuccin").setup()
-- require("lazy").setup(plugins, opts)
vim.cmd.colorscheme "catppuccin"
