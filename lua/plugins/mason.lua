return {
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            require('mason').setup()

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            vim.lsp.config('pyright', {
                cmd = { vim.fn.stdpath('data') .. '/mason/bin/pyright-langserver', '--stdio' },
                root_markers = { 'prightconfig.json', 'pyproject.toml', '.git' },
                capabilities = capabilities,
                filetypes = { 'python' },
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = 'off'
                        }
                    }
                }
            })

            vim.lsp.config('clangd', {
                capabilities = capabilities,
                cmd = { 'clangd', '--header-insertion=never' },
                filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
            })

            vim.lsp.config('ts_ls', {
                capabilities = capabilities,
                filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
            })

            vim.lsp.config('rust_analyzer', {
                capabilities = capabilities,
                cmd = { vim.fn.stdpath('data') .. '/mason/bin/rust-analyzer' },
                filetypes = { 'rust' },
            })

            require('mason-lspconfig').setup({
                ensure_installed = { 'pyright', 'clangd', 'ts_ls', 'html', 'cssls', 'eslint', 'rust_analyzer' },
                automatic_enable = true,
            })

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
        end
    }
}
