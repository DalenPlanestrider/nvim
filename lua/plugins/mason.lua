return {
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = { 'pyright', 'clangd' }
            })

            local cmp_nvim_lsp = require('cmp_nvim_lsp')
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- Pyright
            vim.lsp.config.pyright = {
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = 'off'
                        }
                    }
                }
            }

            -- Clangd
            vim.lsp.config.clangd = {
                capabilities = capabilities,
                cmd = { 'clangd', '--header-insertion=never' }
            }

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
        end
    }
}
