return {
    {
        'nvimdev/indentmini.nvim',
        ft = 'python',
        config = function()
            require('indentmini').setup()

            local function set_indent_colors()
                vim.cmd.highlight('IndentLine guifg=#292929')
                vim.cmd.highlight('IndentLineCurrent guifg=#393939')
            end

            set_indent_colors()
            vim.api.nvim_create_autocmd('ColorScheme', {
                callback = set_indent_colors
            })
        end
    }
}
