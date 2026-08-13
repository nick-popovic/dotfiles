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
					"markdown",
					"markdown_inline",
					"vimdoc",
					"sql",
				},
				highlight = { enable = true },
				indent = { enable = false },
			})

			-- Make sure Treesitter uses the SQL parser for any Dadbod-specific SQL filetypes
			vim.treesitter.language.register("sql", "sqlite")
			vim.treesitter.language.register("sql", "mysql")
			vim.treesitter.language.register("sql", "plsql")
		end,
	},
}
