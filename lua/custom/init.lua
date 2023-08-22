vim.g.mapleader = " "

-- 设置文本编码为 UTF-8
vim.o.encoding = "utf-8"

-- 启用相对行号和绝对行号
vim.wo.relativenumber = true
vim.wo.number = true

-- 启用隐藏模式
vim.o.hidden = true

-- 禁用自动换行
vim.wo.wrap = false

-- 启用智能缩进
vim.o.smartindent = true

-- 设置制表符宽度和软制表符宽度
vim.o.tabstop = 2
vim.o.softtabstop = 2

-- 设置每次操作的缩进宽度
vim.o.shiftwidth = 2

-- 将制表符转换为空格
vim.o.expandtab = true

-- 显示 signcolumn
vim.wo.signcolumn = "yes"

-- 启用增量搜索
vim.o.incsearch = true

-- Configure case-insensitive search with smart case
vim.o.ignorecase = true
vim.o.smartcase = true

-- Disable search highlighting when pressing Esc
-- vim.cmd([[noremap <Esc> :nohls<CR>]])
-- vim.cmd([[cnoremap <Esc> <C-c>:nohls<CR>]])

-- 设置 timeoutlen 和 ttimeoutlen
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 1

vim.o.clipboard = "unnamedplus"

-- 设置初始折叠级别
vim.o.foldlevelstart = 10

vim.cmd("syntax on")
--
-- open files
vim.keymap.set(
	"n",
	"<leader>p",
	"<cmd>lua require('telescope.builtin').find_files({ previewer = false })<CR>",
	{ silent = true }
)
-- open buffers
vim.keymap.set(
	"n",
	"<leader>b",
	"<cmd>lua require('telescope.builtin').buffers({ previewer = false })<CR>",
	{ silent = true }
)

vim.keymap.set(
	"n",
	"<leader>g",
	"<cmd>lua require('telescope.builtin').live_grep({ previewer = false })<CR>",
	{ silent = true }
)
-- format
vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", { silent = true })
-- rename
vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })
-- show diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true })

-- code action
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { noremap = true, silent = true })

-- turn page
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, remap = false })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, remap = false })
