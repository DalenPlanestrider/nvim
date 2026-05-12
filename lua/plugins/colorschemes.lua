return {
    {
        'Mofiqul/vscode.nvim',
        lazy = false,
    },
    {
        'EdenEast/nightfox.nvim',
        lazy = false,
        config = function()
            vim.cmd [[colorscheme carbonfox]]
        end
    },
    {
        'slugbyte/lackluster.nvim',
        lazy = false,
    },
    -- {
    --    'nvim-treesitter/nvim-treesitter'
    --}
}
