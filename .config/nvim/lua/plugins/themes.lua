-- This file is responsible for telling lazy.nvim to install the theme plugins.
-- Without this file, lazy.nvim wouldn't know it needs to download the themes,
-- and themery.nvim would have no themes to switch between.

return {
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },

  -- Tokyonight
  { "folke/tokyonight.nvim", lazy = false },

  -- Gruvbox
  { "ellisonleao/gruvbox.nvim", lazy = false },

  -- Everforest
  { "neanias/everforest-nvim", lazy = false },

  -- Rosé Pine
  { "rose-pine/neovim", name = "rose-pine", lazy = false },
}