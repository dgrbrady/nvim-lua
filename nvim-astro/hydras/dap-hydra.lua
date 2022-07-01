local Hydra = require('hydra')
local dap = require('dap')
local dap_telescope = require('telescope').extensions.dap
local dapui = require('dapui')

local hint = [[
  _n_: continue               _s_: step over                _>_: step into          _<_: step out
  _b_: breakpoint             _c_: conditional breakpoint   _m_: log point message  _e_: eval
  _r_: open repl              _R_: last repl                _<leader>c_: commands   _<leader>o_: configurations
  _<leader>b_: breakpoints    _<leader>v_: variables        _<leader>f_: frames     _q_: quit
]]

local heads = {
  {'n', dap.continue},
  {'s', dap.step_over},
  {'>', dap.step_into},
  {'<', dap.step_out},
  {'b', dap.toggle_breakpoint},
  {
    'c',
    function ()
      dap.set_breakpoint(
        vim.fn.input('Breakpoint condition: ')
      )
    end
  },
  {
    'm',
    function ()
      dap.set_breakpoint(
        nil,
        nil,
        vim.fn.input('Log point message: ')
      )
    end
  },
  {'e', dapui.eval},
  {'r', dap.repl.open},
  {'R', dap.repl.run_last},
  {'<leader>c', function() dap_telescope.commands() end},
  {'<leader>o', function() dap_telescope.configurations() end},
  {'<leader>b', function() dap_telescope.list_breakpoints() end},
  {'<leader>v', function() dap_telescope.variables() end},
  {'<leader>f', function() dap_telescope.frames() end},
  {
    'q',
    nil,
    { exit = true, nowait = true}
  }
}

Hydra({
  hint = hint,
  name = 'DAP Hydra',
  config = {
    invoke_on_body = true,
    color = 'pink',
    hint = {
      position = 'bottom',
      border = 'rounded',
    },
    on_enter = dapui.open,
    on_exit = dapui.close,
  },
  mode = {'n'},
  body = '<leader><leader>x',
  heads = heads
})
