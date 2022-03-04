require 'user.globals'
require 'user.options'
require 'user.plugins'
require 'user.keymaps'
require 'user.colorscheme'
require 'user.nvim-tree'
require 'user.lualine'
require 'user.cmp'
require 'user.lsp'
require 'user.notify'
require 'user.treesitter'
require 'user.autopairs'
require 'user.bufferline'
require 'user.comment'
require 'user.toggleterm'
require 'user.impatient'
require 'user.indentline'
require 'user.autocommands'
require 'user.alpha'
require 'user.whichkey'
require 'user.project'
require 'user.gitsigns'
require 'user.telescope'
require 'user.kommentary'
require 'user.autotag'

if vim.g.nvui then
  vim.cmd [[
    set guifont=Hack\ NF:h10
    NvuiMoveAnimationDuration 0.0125
  ]]
end
