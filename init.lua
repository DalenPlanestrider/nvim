vim.g.mapleader = ' '
vim.g.mpalocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.wrap = false

vim.o.showmode = false

vim.o.undofile = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.scrolloff = 10

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- disable highlight
vim.keymap.set('n', '<leader><BS>', ':bd<CR>')
vim.keymap.set('n', '<leader><Tab>', ':vsplit<CR>')
vim.keymap.set('n', '<leader><CR>', '<C-w><C-w>')
vim.keymap.set('n', '<leader>ec', ':e ~/.config/nvim/init.lua<CR>') -- quick edit config
vim.keymap.set('n', '<leader>ep', ':e ~/.config/nvim/lua/plugins.lua<CR>') -- quick edit plugins lit

require('plugins')

vim.cmd 'colorscheme lackluster-night'

local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.clangd.setup({
    capabilities=capabilities,
    cmd = {
        'clangd',
        '--header-insertion=never',
    },
})

lspconfig.rust_analyzer.setup({
    capabilities=capabilities,
    settings = {
        ['rust_analyzer'] = {
            checkOnSave = {
                command = 'cargo clippy'
            }
        }
    }
})

local cmp = require('cmp')

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmdline' },
  })
})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
