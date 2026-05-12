return {
  "romus204/tree-sitter-manager.nvim",
  config = function()
    require("tree-sitter-manager").setup({
      auto_install = true,
      ensure_installed = {
        "c", "cpp", "python", "rust",
        "html", "css", "javascript", "typescript", "tsx",
      },
    })
  end,
}
