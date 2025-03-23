return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = false,
        ensure_installed = {
          "bash",
          "python", "c", "java", "go",
          "html", "css", "scss",
          "javascript", "typescript",
          "json",
          "lua",
        },
        highlight = { enable = true },
        indent = { enable = false },
      })
    end
  }
}
