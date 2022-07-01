local Hydra = require('hydra')
local aerial = require('aerial')
local telescope_builtin = require('telescope.builtin')

local hint = [[
^ _d_: next diagnostic   _D_: previous diagnostic
^ _n_: next symbol       _N_: previous symbol
^ _r_: references        _a_: code action
^ _s_: toggle tree

^ _q_: quit
]]

local heads = {
  { 'd', vim.diagnostic.goto_next },
  { 'D', vim.diagnostic.goto_prev },
  {
    'a',
    function ()
      vim.lsp.buf.code_action()
      return '<Ignore>'
    end,
  },
  { 'n',aerial.next },
  {
    'N',
    function ()
      aerial.next(-1)
    end,
  },
  {
    's',
    function ()
      if aerial.is_open() then
        aerial.close()
      else
        aerial.open()
      end
    end,
  },
  {
    'r',
    function ()
      telescope_builtin.lsp_references()
      return '<Ignore>'
    end,
  },
  {
    'q',
    nil,
    { exit = true, nowait = true}
  },
}

Hydra({
  hint = hint,
  name = 'LSP Hydra',
  config = {
    invoke_on_body = true,
    color = 'pink',
    hint = {
      position = 'bottom',
      border = 'rounded'
    },
    on_enter = function ()
        aerial.open()
    end,
    on_exit = function ()
        aerial.close()
    end
  },
  mode = {'n'},
  body = '<leader><leader>l',
  heads = heads
})
