-- local colorscheme = 'default_theme'
-- local kanagawa_ok, _ = pcall(require, 'kanagawa')
--
-- if kanagawa_ok then
--   colorscheme = 'kanagawa'
-- end
--local dap_maps = require('user.dbg.wk-maps')
local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme
  colorscheme = 'default_theme',

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = false, -- sets vim.opt.relativenumber
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
    },
    o = {
      colorcolumn = '80'
    }
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = {
      fg = "#abb2bf",
    },
    -- Modify the highlight groups
    highlights = function(highlights)
      local C = require "default_theme.colors"

      highlights.Normal = { fg = C.fg, bg = C.bg }
      return highlights
    end,
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Disable AstroNvim ui features
  ui = {
    nui_input = true,
    telescope_select = true,
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },
      ['nvim-neo-tree/neo-tree.nvim'] = { disable = true },
      -- You can also add new plugins here as well:
      -- {'rebelot/kanagawa.nvim', as = 'kanagawa', config = function ()
      --   require('kanagawa').setup({
      --     statementStyle = { bold = false }
      --   })
      -- end},

      -- Treesitter plugins
      {'nvim-treesitter/playground', run = ':TSInstall query'},
      {'ziontee113/syntax-tree-surfer', branch = '2.1'},
      {'nvim-treesitter/nvim-treesitter-textobjects'},

      -- DAP plugins
      {
        'puremourning/vimspector',
        cmd = { 'VimspectorInstall', 'VimspectorUpdate'},
        fn = { 'vimspector#Launch()', 'vimspector#ToggleBreakpoint', 'vimspector#Continue' },
        config = function ()
          vim.cmd [[packadd! vimspector]]
        end
      },
      {'mfussenegger/nvim-dap'},
      {'nvim-telescope/telescope-dap.nvim'},
      {'rcarriga/nvim-dap-ui'},
      {'theHamsta/nvim-dap-virtual-text'},
      {'Pocco81/DAPInstall.nvim'},

      -- Other plugins
      {'ahmedkhalf/project.nvim'},
      {'kyazdani42/nvim-tree.lua'},
      {'ggandor/lightspeed.nvim'},
      {'tpope/vim-fugitive'},
      {'tpope/vim-surround'},
      {'anuvyklack/hydra.nvim', requires = 'anuvyklack/keymap-layer.nvim'},
    },
    -- All other entries override the setup() call for default plugins
    treesitter = function (config)
      config.textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner"
          }
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer'
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer'
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer'
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer'
          }
        }
      }
      config.ensure_installed = { "lua" }
      return config
    end,
    ["toggleterm"] = function(config)
      config.direction = 'horizontal'
      function _G.set_terminal_keymaps()
        local opts = {noremap = true}
        vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', 'jj', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd [[
        autocmd! TermOpen term://* lua set_terminal_keymaps()
        let &shell = 'powershell'
        let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
        let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        set shellquote= shellxquote=
      ]]

      return config
    end,
    -- ["neo-tree"] = function (config)
    --   config.filesystem.filtered_items.hide_dotfiles = false
    --   return config
    -- end,
    ["null-ls"] = function(config)
      -- local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      -- config.sources = {
      --   -- Set a formatter
      --   null_ls.builtins.formatting.prettier,
      --   -- Set a linter
      --   null_ls.builtins.diagnostics.eslint,
      -- }
      -- set up null-ls's on_attach function
      config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config -- return final config table
    end,
    ["nvim-lsp-installer"] = {
      ensure_installed = { "sumneko_lua" },
    },
    packer = {
      compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- which-key registration table for normal mode, leader,leader prefix
          ['<leader>'] = {
            name = 'Hydras',
            l = 'LSP Hydra',
            g = 'Git Hydra',
            x = 'DAP Hydra'
          },
          -- which-key registration table for normal mode, leader prefix
          ['Y'] = {':%y+<cr>', 'Yank file'},
          ['Q'] = {':qall<cr>', 'Quit All'},
          ['e'] = {'<cmd>NvimTreeToggle<cr>', 'Toggle NvimTree'},
          ['o'] = {'<cmd>NvimTreeFocus<cr>', 'Focus NvimTree'},
          ['P'] = {'<cmd>Telescope projects<cr>', 'Open projects'},
          ['b'] = {
            name = 'Buffers',
            r = {'<cmd>BufferLineMoveNext<cr>', 'Move Buffer Right'},
            l = {'<cmd>BufferLineMovePrev<cr>', 'Move Buffer Left'},
            p = {'<cmd>BufferLinePick<cr>', 'Pick Buffer'},
            ['c'] = {
              name = 'Close',
              l = {'<cmd>BufferLineCloseLeft<cr>', 'Close Buffers To Left'},
              r = {'<cmd>BufferLineCloseRight<cr>', 'Close Buffers To Right'},
            },
            ['s'] = {
              name = 'Sort',
              d = {'<cmd>BufferLineSortByDirectory<cr>', 'Sort By Directory'},
              e = {'<cmd>BufferLineSortByExtension<cr>', 'Sort By Extension'}
            }
          },
          --['x'] = dap_maps,
        },
      },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without lsp-installer
    servers = {
      "angularls",
      "cssls",
      "cssmodules_ls",
      "dockerls",
      "eslint",
      "html",
      "jsonls",
      "sumneko_lua",
      "tsserver",
      "yamlls"
    },
    -- add to the server on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = {
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = false,
    underline = true,
  },

  -- This function is run last
  -- good place to configure mappings and vim options
  polish = function()
    -- Set key bindings
    vim.keymap.set("n", "<C-s>", ":w!<cr>")

    -- Setup dap
    require('user.dbg')

    -- Invoke the Hydras
    require('user.hydras.lsp-hydra')
    require('user.hydras.git-hydra')
    require('user.hydras.dap-hydra')

    -- Setup project.nvim
    local status_ok, project = pcall(require, "project_nvim")
    if status_ok then
      project.setup({
	      ---@usage set to false to disable project.nvim.
	      --- This is on by default since it's currently the expected behavior.
	      active = true,

	      on_config_done = nil,

	      ---@usage set to true to disable setting the current-woriking directory
	      --- Manual mode doesn't automatically change your root directory, so you have
	      --- the option to manually do so using `:ProjectRoot` command.
	      manual_mode = false,

	      ---@usage Methods of detecting the root directory
	      --- Allowed values: **"lsp"** uses the native neovim lsp
	      --- **"pattern"** uses vim-rooter like glob pattern matching. Here
	      --- order matters: if one is not detected, the other is used as fallback. You
	      --- can also delete or rearangne the detection methods.
	      -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
	      detection_methods = { "pattern" },

	      ---@usage patterns used to detect root dir, when **"pattern"** is in detection_methods
	      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

	      ---@ Show hidden files in telescope when searching for files in a project
	      show_hidden = false,

	      ---@usage When set to false, you will get a message when project.nvim changes your directory.
	      -- When set to false, you will get a message when project.nvim changes your directory.
	      silent_chdir = true,

	      ---@usage list of lsp client names to ignore when using **lsp** detection. eg: { "efm", ... }
	      ignore_lsp = {},

	      ---@type string
	      ---@usage path to store the project history for use in telescope
        datapath = vim.fn.stdpath("data"),
      })
    end

    local tele_status_ok, telescope = pcall(require, "telescope")
    if tele_status_ok then
      telescope.load_extension('projects')
    end

    -- Setup nvim-tree
    require('nvim-tree').setup({
      respect_buf_cwd = true,
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      renderer = {
        indent_markers = {
          enable = true
        }
      },
      git = {
        enable = false
      },
    })

    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })
    vim.cmd [[
      autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})
      set guifont=Hack\ NF:h10
    ]]
    -- Set up custom filetypes
    vim.filetype.add {
      filename = {
        ["nginx.conf.template"] = "nginx"
      }
      -- extension = {
      --   foo = "fooscript",
      -- },
      -- filename = {
      --   ["Foofile"] = "fooscript",
      -- },
      -- pattern = {
      --   ["~/%.config/foo/.*"] = "fooscript",
      -- },
    }
  end,
}

return config
