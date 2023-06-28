
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
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- 设置每次操作的缩进宽度
vim.o.shiftwidth = 4

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

