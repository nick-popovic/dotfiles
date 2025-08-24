return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Make sure to load this before all other start plugins
  config = function()
    -- Load the colorscheme here
    vim.cmd.colorscheme("catppuccin")
  end,
}