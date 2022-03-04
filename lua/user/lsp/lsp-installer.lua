local status_ok, lspconfig = pcall(require, "lspconfig")
-- local lsp_installer_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')

if not status_ok then
	return
end

-- lsp_installer.settings.install_root_dir = vim.fn.stdpath('data') .. '/lsp_servers'

local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}
--[[ for _, server in lsp_installer.get_installed_servers() do
  print(server.name)
  lsp_installer.on_server_ready(function (server)
    local capabilities = require("user.lsp.handlers").capabilities
    local on_attach = require("user.lsp.handlers").on_attach
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    if server.name == 'jsonls' then
      local jsonls_opts = require("user.lsp.settings.jsonls")
      local new_opts = vim.tbl_deep_extend("force", jsonls_opts, opts)

      new_opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- lspconfig[server].setup(coq.lsp_ensure_capabilities(new_opts))
      -- lspconfig[server].setup(new_opts)
      server:setup(new_opts)
    end

    if server.name == 'sumneko_lua' then
      local sumneko_opts = require("user.lsp.settings.sumneko_lua")
      local new_opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
      -- lspconfig[server].setup(coq.lsp_ensure_capabilities(new_opts))
      -- lspconfig[server].setup(new_opts)
      server:setup(new_opts)
    end

    if server.name == 'tsserver' then
      local tsserver_opts = require('user.lsp.settings.tsserver')
      local new_opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
      -- lspconfig[server].setup(coq.lsp_ensure_capabilities(new_opts))
      -- lspconfig[server].setup(new_opts)
      server:setup(new_opts)
    end

    if server.name == 'angularls' then
      local ngserver_opts = require('user.lsp.settings.angularls')
      local new_opts = vim.tbl_deep_extend("force", ngserver_opts, opts)
      -- lspconfig[server].setup(coq.lsp_ensure_capabilities(new_opts))
      -- lspconfig[server].setup(new_opts)
      server:setup(new_opts)
    end

    if server.name == 'tailwindcss' then
      local tailwind_opts = require('user.lsp.settings.tailwindcss')
      local new_opts = vim.tbl_deep_extend("force", tailwind_opts, opts)
      -- lspconfig[server].setup(coq.lsp_ensure_capabilities(new_opts))
      -- lspconfig[server].setup(new_opts)
      server:setup(new_opts)
    end

    if server.name == 'cssls' then
      local cssls_opts = require('user.lsp.settings.cssls')
      local new_opts = vim.tbl_deep_extend("force", cssls_opts, opts)
      new_opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- lspconfig[server].setup(coq.lsp_ensure_capabilities(new_opts))
      -- lspconfig[server].setup(new_opts)
      server:setup(new_opts)
    end
    -- server:setup(opts)
  end)
end ]]

local servers = {
  'jsonls',
  'sumneko_lua',
  'tsserver',
  'angularls',
  'eslint',
  'nginx',
  'tailwindcss',
  'cssls',
  'html',
  'pylsp',
}

--[[ vim.g.coq_settings = {
  auto_start = 'shut-up',
  -- clients = {
  --   tree_sitter = {
  --     slow_threshold = 0.2,
  --   }
  -- },
  keymap = {
    recommended = false,
    jump_to_mark = null
  },
  display = {
    ghost_text = {
      enabled = false
    }
  }
} ]]

-- local coq = require('coq')
for _, server in ipairs(servers) do
  if server == 'jsonls' then
    local jsonls_opts = require("user.lsp.settings.jsonls")
    local new_opts = vim.tbl_deep_extend("force", jsonls_opts, opts)

    new_opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- lspconfig[server].setup(coq.lsp_ensure_capabilities(new_opts))
    lspconfig[server].setup(new_opts)
  end

  if server == 'sumneko_lua' then
    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
    local new_opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    -- lspconfig[server].setup(coq.lsp_ensure_capabilities(new_opts))
    lspconfig[server].setup(new_opts)
  end

  if server == 'tsserver' then
    local tsserver_opts = require('user.lsp.settings.tsserver')
    local new_opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
    -- lspconfig[server].setup(coq.lsp_ensure_capabilities(new_opts))
    lspconfig[server].setup(new_opts)
  end

  if server == 'angularls' then
    local ngserver_opts = require('user.lsp.settings.angularls')
    local new_opts = vim.tbl_deep_extend("force", ngserver_opts, opts)
    -- lspconfig[server].setup(coq.lsp_ensure_capabilities(new_opts))
    lspconfig[server].setup(new_opts)
  end

  if server == 'tailwindcss' then
    local tailwind_opts = require('user.lsp.settings.tailwindcss')
    local new_opts = vim.tbl_deep_extend("force", tailwind_opts, opts)
    -- lspconfig[server].setup(coq.lsp_ensure_capabilities(new_opts))
    lspconfig[server].setup(new_opts)
  end

  if server == 'cssls' then
    local cssls_opts = require('user.lsp.settings.cssls')
    local new_opts = vim.tbl_deep_extend("force", cssls_opts, opts)
    new_opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- lspconfig[server].setup(coq.lsp_ensure_capabilities(new_opts))
    lspconfig[server].setup(new_opts)
  end

  if server == 'html' then
    local html_opts = require('user.lsp.settings.html')
    local new_opts = vim.tbl_deep_extend('force', html_opts, opts)
    new_opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig[server].setup(new_opts)
  end

  if server == 'pylsp' then
    lspconfig[server].setup(opts)
  end
  --if server == 'nginx' then
  --  local nginx_opts = require('user.lsp.settings.nginx')
  --  local new_opts = vim.tbl_deep_extend("force", nginx_opts, opts)
  --  lspconfig[server].setup(new_opts)
  --end

  -- if server == 'eslint' then
  --   local eslint_opts = require('user.lsp.settings.eslint')
  --   local new_opts = vim.tbl_deep_extend("force", eslint_opts, opts)
  --   lspconfig[server].setup(new_opts)
  -- end
end
