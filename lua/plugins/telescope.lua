return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- ── search args ──────────────────────────────────────────
            local ignore_file = vim.fn.expand('~/.config/ripgrep/ignore')

            local base_grep = {
                'rg', '--color=never', '--no-heading', '--with-filename',
                '--line-number', '--column', '--smart-case',
            }

            -- normal mode: ignore .gitignore, but honor the global junk list
            local vimgrep_args = vim.deepcopy(base_grep)
            vim.list_extend(vimgrep_args,
                { '--hidden', '--no-ignore-vcs', '--ignore-file', ignore_file })

            -- escape hatch: no ignore rules at all (except .git itself)
            local everything_args = vim.deepcopy(base_grep)
            vim.list_extend(everything_args,
                { '--hidden', '--no-ignore', '--glob', '!.git/' })

            -- file listing for find_files, same rules as normal grep
            local find_command = {
                'rg', '--files',
                '--hidden', '--no-ignore-vcs', '--ignore-file', ignore_file,
            }

            -- ── telescope ────────────────────────────────────────────
            require('telescope').setup({
                defaults = {
                    vimgrep_arguments = vimgrep_args,
                },
                pickers = {
                    find_files = { find_command = find_command },
                },
            })

            -- ── keymaps ──────────────────────────────────────────────
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'find buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'find help tags' })

            vim.keymap.set('n', '<leader>fA', function()
                builtin.live_grep({ vimgrep_arguments = everything_args })
            end, { desc = 'grep everything' })
        end
    }
}
