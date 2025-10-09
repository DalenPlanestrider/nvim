vim.g.mapleader = ' '
vim.g.mpalocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.wrap = false
vim.opt.termguicolors = true

vim.o.showmode = false

vim.o.undofile = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.scrolloff = 8

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- disable highlight
vim.keymap.set('n', '<leader><BS>', ':bd<CR>')
vim.keymap.set('n', '<leader><Tab>', ':vsplit<CR>')
vim.keymap.set('n', '<leader><CR>', '<C-w><C-w>')
vim.keymap.set('n', '<leader>ec', ':e ~/.config/nvim/init.lua<CR>') -- quick edit config
vim.keymap.set('n', '<leader>ep', ':e ~/.config/nvim/lua/plugins.lua<CR>') -- quick edit plugins lit

require("config.lazy")
