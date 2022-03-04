--[[
local default_schemas = nil
local status_ok, schemastore = pcall(require, 'schemastore')
if status_ok then
  default_schemas = schemastore.json.schemas()
end


local opts = {
  settings = {
    json = {
      schemas = default_schemas,
    },
  },
}

return opts ]]
local npm = 'E:\\nodejs'
local cmd = { npm .. '\\vscode-json-language-server.cmd', '--stdio' }
local opts = {
  cmd = cmd
}

return opts
