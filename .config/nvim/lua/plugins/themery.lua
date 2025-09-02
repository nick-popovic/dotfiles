
return {
  "zaldih/themery.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local themery = require("themery")
    themery.setup({
      initial_theme = "catppuccin",
      themes = {
        "catppuccin",
        "tokyonight",
        "gruvbox",
        "everforest",
        "rose-pine",
      },
    })

    vim.keymap.set("n", "<leader>th", "<cmd>Themery<CR>", { desc = "Open theme picker" })
  end,
}
