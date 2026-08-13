return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	config = function()
		-- Neo-tree keymaps
		vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
		vim.keymap.set(
			"n",
			"<leader>b",
			":Neotree buffers reveal float<CR>",
			{ desc = "Show buffers in Neo-tree float" }
		)

		-- Neo-tree setup
		require("neo-tree").setup({
			close_if_last_window = true,
			enable_git_status = true,
			enable_diagnostics = true,
			sources = { "filesystem", "buffers", "git_status" },

			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				use_libuv_file_watcher = true,
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},

			buffers = {
				follow_current_file = {
					enabled = true,
				},
				show_unloaded = true,
			},
			window = {
				position = "left",
				width = 30,
			},
		})
	end,
}
