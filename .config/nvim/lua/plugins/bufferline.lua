return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers", -- makes it act like VS Code tabs
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            }
          },
          show_buffer_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          separator_style = "slant", -- or "thin", "padded_slant", etc
        },
      })
  
      -- Optional: cycle through buffers like tabs
      vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next Buffer" })
      vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous Buffer" })
    end,
  }
  