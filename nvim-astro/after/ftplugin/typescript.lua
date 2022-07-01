local Hydra = require('hydra')
local aerial = require('aerial')
local telescope_builtin = require('telescope.builtin')
local sts = require('syntax-tree-surfer')

local hint = [[
LSP heads
---------
^ _d_: next diagnostic   _D_: previous diagnostic
^ _n_: next symbol       _N_: previous symbol
^ _r_: references        _a_: code action
^ _s_: toggle tree

STS heads
---------
^ _p_: next property     _P_: previous property   
^ _m_: next method       _M_: previous method
^ _i_: next import       _I_: previous import
^ _c_: next comment      _C_: previous comment

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
  {
    'p',
    function ()
      sts.filtered_jump({'public_field_definition'}, true)
    end
  },
  {
    'P',
    function ()
      sts.filtered_jump({'public_field_definition'}, false)
    end
  },
  {
    'm',
    function ()
      sts.filtered_jump({'method_definition'}, true)
    end
  },
  {
    'M',
    function ()
      sts.filtered_jump({'method_definition'}, false)
    end
  },
  {
    'i',
    function ()
      sts.filtered_jump({'import_statement'}, true)
    end
  },
  {
    'I',
    function ()
      sts.filtered_jump({'import_statement'}, false)
    end
  },
  {
    'c',
    function ()
      sts.filtered_jump({'comment'}, true)
    end
  },
  {
    'C',
    function ()
      sts.filtered_jump({'comment'}, false)
    end
  },
}


Hydra({
  hint = hint,
  name = 'LSP Hydra',
  config = {
    invoke_on_body = true,
    color = 'pink',
    buffer = true,
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
