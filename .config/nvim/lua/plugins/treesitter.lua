return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				modules = {},
				sync_install = false,
				auto_install = true,
				ignore_install = { "" },
				ensure_installed = {
					"bash",
					"python",
					"c",
					"java",
					"go",
					"html",
					"css",
					"scss",
					"javascript",
					"typescript",
					"json",
					"lua",
				},
				highlight = { enable = true },
				indent = { enable = false },
			})
		end,
	},
}
