local Hydra = require('hydra')
local gitsigns = require('gitsigns')
local telescope = require('telescope.builtin')

local hint = [[
 _n_: next hunk     _N_: prev hunk       _p_: preview hunk
 _s_: stage hunk    _S_: stage buffer    _u_: undo stage hunk
 _d_: show deleted  _b_: blame line      _B_: blame show full 
 _c_: commit        _>_: push to remote  _<_: pull from remote
 _t_: status        _q_: exit
]]

Hydra({
   hint = hint,
   config = {
      color = 'pink',
      invoke_on_body = true,
      hint = {
        position = 'bottom',
        border = 'rounded'
      },
      on_enter = function()
        vim.bo.modifiable = false
        gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(true)
      end,
      on_exit = function()
        gitsigns.toggle_linehl(false)
        vim.cmd 'echo' -- clear the echo area
      end
   },
   mode = {'n','x'},
   body = '<leader><leader>g',
   heads = {
      { 'n', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns.next_hunk() end)
            return '<Ignore>'
         end, { expr = true } },
      { 'N', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return '<Ignore>'
         end, { expr = true } },
      { 's', ':Gitsigns stage_hunk<CR>', { silent = true } },
      { 'u', gitsigns.undo_stage_hunk },
      { 'S', gitsigns.stage_buffer },
      { 'p', gitsigns.preview_hunk },
      { 'd', gitsigns.toggle_deleted, { nowait = true } },
      { 'b', gitsigns.blame_line },
      { 'B', function() gitsigns.blame_line{ full = true } end },
      { 'c', '<cmd>G commit<cr>', { exit = true } },
      { '>', '<cmd>G push<cr>', { exit = true }},
      { '<', '<cmd>G pull<cr>', { exit = true } },
      { 't', telescope.git_status, { exit = true } },
      { 'q', nil, { exit = true, nowait = true } },
   }
})
