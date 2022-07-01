require('dapui').setup()
require('nvim-dap-virtual-text').setup()
vim.g.dap_virtual_text = true
local wk = require('which-key')
local wk_maps = require('user.dbg.wk_maps')
wk.register(wk_maps)

-- Debug adapters
require('user.dbg.node')
