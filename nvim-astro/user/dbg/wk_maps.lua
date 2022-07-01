local telescope = require('telescope')
telescope.load_extension('dap')

local dap = require('dap')
local dap_telescope = telescope.extensions.dap

local maps = {
  ['<leader>x'] = {
    name = 'Debugger',
    c = { dap.continue, 'Continue' },
    s = {
      name = 'Step',
      v = { dap.step_over, 'Step over' },
      i = { dap.step_into, 'Step into' },
      o = { dap.step_out, 'Step out' },
    },
    b = {
      name = 'Breakpoints',
      t = {dap.toggle_breakpoint, 'Toggle breakpoint'},
      c = {
        function ()
          dap.set_breakpoint(
            vim.fn.input('Breakpoint condition: ')
          )
        end,
        'Conditional breakpoint'
      },
      m = {
        function ()
          dap.set_breakpoint(
            nil,
            nil,
            vim.fn.input('Log point message: ')
          )
        end,
        'Set log point message'
      }
    },
    r = {
      name = 'Repl',
      o = { dap.repl.open, 'Open' },
      l = { dap.repl.run_last, 'Run last' }
    },
    t = {
      name = 'Telescope',
      c = { dap_telescope.commands, 'Commands' },
      o = { dap_telescope.configurations, 'Configurations' },
      b = { dap_telescope.list_breakpoints, 'Breakpoints' },
      v = { dap_telescope.variables, 'Variables' },
      f = { dap_telescope.frames, 'Frames' },
    }
  }
}

return maps
