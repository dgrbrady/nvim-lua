local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Have packer manage itself

  -- LSP plugins
  use 'neovim/nvim-lspconfig' -- enable LSP
  use 'williamboman/nvim-lsp-installer'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'nvim-lua/lsp-status.nvim'
  use 'b0o/schemastore.nvim' -- provide json schemas
  use 'folke/lua-dev.nvim' -- lua LSP

  -- Completion plugins
  --[[ use {
    'ms-jpq/coq_nvim',
    branch = 'coq'
  }
  use {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts'
  } ]]
  --[=====[
  use 'SirVer/ultisnips'
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "quangnguyen30192/cmp-nvim-ultisnips",
      config = function()
        -- optional call to setup (see customization section)
        require("cmp_nvim_ultisnips").setup{}
      end,
      -- If you want to enable filetype detection based on treesitter:
      requires = { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
      local cmp = require("cmp")
      local default_cmp_opts = require('user.cmp');
      local ultisnips_opts = {
        snippet = {
        expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
      },
      sources = {
      { name = "ultisnips" },
        -- more sources
      },
      -- recommended configuration for <Tab> people:
      mapping = {
        ["<Tab>"] = cmp.mapping(
        function(fallback)
      cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
    end,
    { "i", "s", [[ "c" (to enable the mapping in command mode) ]] }
      ),
      ["<S-Tab>"] = cmp.mapping(
        function(fallback)
      cmp_ultisnips_mappings.jump_backwards(fallback)
    end,
    { "i", "s", [[ "c" (to enable the mapping in command mode) ]] }
      ),
      },
      }
      local final_opts = vim.tbl_deep_extend('force', default_cmp_opts, ultisnips_opts)
      cmp.setup(final_opts)
      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        sources = {
        { name = 'buffer' }
        }
        })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
        { name = 'path' }
        }, {
        { name = 'cmdline' }
        })
        })

      vim.cmd("hi link CmpItemMenu Comment")
    end,
  })
  --]=====]
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer' -- buffer completions
  use 'hrsh7th/cmp-path' -- path completions
  use 'hrsh7th/cmp-cmdline' -- cmdline completions
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

  -- Editor plugins
  use 'nvim-lua/popup.nvim' -- An implementation of the Popup API from vim in Neovim
  use 'nvim-lua/plenary.nvim' -- Useful lua functions used ny lots of plugins
  use 'nvim-telescope/telescope.nvim'
  use 'tpope/vim-fugitive' -- git wrapper
  use 'rcarriga/nvim-notify'
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/bufferline.nvim'
  use 'famiu/bufdelete.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'akinsho/toggleterm.nvim' -- usein to persist and toggle multiple terminals during an editing session
  use 'goolord/alpha-nvim'
  use 'antoinemadec/FixCursorHold.nvim' -- This is needed to fix lsp doc highlight
  use 'folke/which-key.nvim'
  use 'ahmedkhalf/project.nvim'
  use 'rafcamlet/nvim-luapad'
  use 'j-hui/fidget.nvim'
  use 'windwp/nvim-ts-autotag'

  -- Testing plugins
  -- use {
  --   'google/vim-coverage',
  --   requires = {{'google/vim-maktaba'}}
  -- }
  -- use {
  --   'google/vim-glaive',
  --   run = function () vim.fn['glaive#Install']() end
  -- }

  -- Themes
  use 'rebelot/kanagawa.nvim'

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- Motion plugins
  use 'tpope/vim-surround' -- easy editing of parenthesis, brackets, quotes, xml/html tags, etc
  use 'b3nj5m1n/kommentary' -- Easily comment stuff
  use 'windwp/nvim-autopairs' -- Autopairs, integrates with cmp, treesitter and coq
  use 'ggandor/lightspeed.nvim'

  -- Icon plugins
  use 'onsails/lspkind-nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'ryanoasis/vim-devicons'

  -- Git
  use 'lewis6991/gitsigns.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
  require'nvim-web-devicons'.setup{}
end)
