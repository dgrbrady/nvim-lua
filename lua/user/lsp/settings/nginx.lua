-- local lspconfig = req('lspconfig')
local pyScripts = 'C:\\Users\\david.brady\\AppData\\Roaming\\Python\\Python310\\Scripts\\'
-- local opts = {
--   default_config = {
--     cmd = { pyScripts .. 'nginx-language-server.exe' },
--     filetypes = { 'nginx' },
--     -- root_dir = function(filename)
--     --   return vim.loop.cwd()
--     -- end,
--   }
-- }
--
-- return opts
-- local M = {}
LaunchNginxLsp = function ()
  vim.notify('Launching Nginx LSP')
  local cmd = { pyScripts .. 'nginx-language-server.exe' }
  local clientId = vim.lsp.start_client({
    cmd = cmd
  })
  vim.lsp.buf_attach_client(0, clientId)
end
-- return M
vim.cmd([[
  command! -range LaunchNginxLsp execute 'lua LaunchNginxLsp()'
]])
