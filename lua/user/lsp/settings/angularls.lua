local npm = 'E:\\nodejs'
local ts_probe = npm .. '\\node_modules'
local ng_probe = npm .. '\\node_modules\\@angular\\language-server\\node_modules'
local ngserver = { 'ngserver.cmd', '--stdio', '--tsProbeLocations', ts_probe, '--ngProbeLocations', ng_probe }
-- local ngserver_cmd = vim.fn.stdpath('data') .. '\\lsp_servers\\angularls\\node_modules\\.bin\\ngserver.cmd'
local opts = {
  cmd = ngserver,
  -- cmd = { ngserver_cmd, '--stdio' }
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = ngserver
  end,
}

return opts
