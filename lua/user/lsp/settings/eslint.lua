local npx = 'C:\\Program Files\\nodejs\\npx.cmd'

local opts = {
  cmd = { npx, 'vscode-eslint-language-server', '--stdio' }
}

return opts
