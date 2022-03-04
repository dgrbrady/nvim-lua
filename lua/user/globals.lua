-- utility for inspecting tables
function _G.inspect(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

-- utility for requiring modules safely
function _G.req(moduleName, config)
  local onError = nil
  local onSuccess = nil
  if config then
    onError = config.onError
    onSuccess = config.onSuccess
  end
  local status_ok, module = pcall(require, moduleName)
  if not status_ok then
    vim.notify('Failed to require module: ' .. moduleName, 'error')
    if onError then
      return onError()
    end
    return
  end
  if onSuccess then
    return onSuccess(module)
  end
  return module
end
