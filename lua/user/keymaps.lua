local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap comma as leader key
-- keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Convenience bindings
keymap('n', '>', '>>', opts)
keymap('n', '<', '<<', opts)
keymap('n', ';', ':', opts)
keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>wq', ':wq<CR>', opts)
keymap('n', '<leader>q', ':q<CR>', opts)
keymap('n', '<leader>qa', ':qall<CR>', opts)
keymap('n', '<leader>Q', ':q!<CR>', opts)
keymap('n', '<leader>/', ':nohl<CR>', opts)
keymap('n', '<leader>o', 'o<ESC>', opts)
keymap('n', '<leader>O', 'O<ESC>', opts)
keymap('n', '<leader>vc', ':vsplit $MYVIMRC<CR>', opts)
keymap('n', '<leader>pd', ':lua PeekDefinition()<CR>', opts)
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Telescope bindings
keymap('n', '<leader>T', ':Telescope<CR>', opts)
keymap('n', '<leader>t', ':Telescope ', opts)
keymap('n', '<leader>tf', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>tg', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>tb', ':Telescope buffers<CR>', opts)
keymap('n', '<leader>te', ':Telescope file_browser<CR>', opts)

-- Trouble bindings
-- keymap('n', '<leader>xx', '<cmd>Trouble<CR>', opts)
-- keymap('n', '<leader>xw', '<cmd>Trouble lsp_workspace_diagnostics<CR>', opts)
-- keymap('n', '<leader>xd', '<cmd>Trouble lsp_document_diagnostics<CR>', opts)
-- keymap('n', '<leader>xl', '<cmd>Trouble loclist<CR>', opts)
-- keymap('n', '<leader>xf', '<cmd>Trouble quickfix<CR>', opts)
-- keymap('n', '<leader>xr', '<cmd>Trouble lsp_references<CR>', opts)

-- Bufferline bindings
keymap('n', '<S-l>', ':BufferLineCycleNext<CR>', opts)
keymap('n', '<S-h>', ':BufferLineCyclePrev<CR>', opts)
keymap('n', '<leader>ba', ':BufferLineMoveNext<CR>', opts)
keymap('n', '<leader>bb', ':BufferLineMovePrev<CR>', opts)
keymap('n', '<leader>bp', ':BufferLinePick<CR>', opts)
keymap('n', '<leader>bcl', ':BufferLineCloseLeft<CR>', opts)
keymap('n', '<leader>bcr', ':BufferLineCloseRight<CR>', opts)
keymap('n', '<leader>bc', ':lua require("bufdelete").bufdelete(0, true)<CR>', opts)
keymap('n', '<leader>bsd', ':BufferLineSortByDirectory<CR>', opts)
keymap('n', '<leader>bse', ':BufferLineSortByExtension<CR>', opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
