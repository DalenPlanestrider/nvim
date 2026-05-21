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
vim.opt.cinoptions = 'l1'

-- Treesitter-based folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevelstart = 99  -- open all folds by default
vim.o.foldtext = ''        -- show first line of fold as-is (clean look)

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- disable highlight
vim.keymap.set('n', '<leader><BS>', ':bd<CR>')
vim.keymap.set('n', '<leader><Tab>', ':vsplit<CR>')
vim.keymap.set('n', '<leader><CR>', '<C-w><C-w>')
vim.keymap.set('n', '<leader>ec', ':e ~/.config/nvim/init.lua<CR>') -- quick edit config
vim.keymap.set('n', '<leader>ep', ':e ~/.config/nvim/lua/plugins.lua<CR>') -- quick edit plugins lit'

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
    --vim.bo.indentexpr = "v:lua.vim.treesitter.indentexpr()"
  end,
})

require("config.lazy")
