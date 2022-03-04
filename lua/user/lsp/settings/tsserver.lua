local custom_attach = require('user.lsp.handlers').on_attach

local opts = {
  -- init_options = require('nvim-lsp-ts-utils').init_options,
  cmd = { 'typescript-language-server.cmd', '--stdio' },
  root_dir = vim.loop.cwd,
  on_attach = function(client, bufnr)
    custom_attach(client, bufnr)
    local ts_utils = require('nvim-lsp-ts-utils')
    ts_utils.setup({
      auto_inlay_hints = false,
      enable_import_on_completion = true,
      formatter = 'eslint_d',
      formatter_args = {
        '--fix-to-stdout', '--stdin', '--stdin-filename', '$FILENAME'
      },
    })
    ts_utils.setup_client(client)
  end
}

return opts
