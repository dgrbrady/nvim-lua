local null_ls = require('null-ls')
local custom_attach = require('user.lsp.handlers').on_attach

null_ls.setup({
  -- filetypes = { "javascriptreact", "typescript", "vue", "javascript", "typescriptreact", "html", "css", "scss", "json" },
  on_attach = function(client, bufnr)
    custom_attach(client,bufnr)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
  sources = {
      -- null_ls.builtins.diagnostics.eslint_d.with(local_bin),
      null_ls.builtins.diagnostics.eslint_d.with({ extra_filetypes = {"html", "css", "scss", }}),
      null_ls.builtins.code_actions.eslint_d.with({ extra_filetypes = {"html", "css", "scss", }}),
      null_ls.builtins.formatting.eslint_d.with({ extra_filetypes = {"html", "css", "scss", }}),
    },
})
