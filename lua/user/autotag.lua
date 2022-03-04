local status_ok, autotag = pcall(require, "nvim-ts-autotag")
if not status_ok then
  vim.notify('nvim-ts-autotag not installed')
	return
end

autotag.setup()
