return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod_ui"
			vim.g.db_ui_show_database_icon = 1
			vim.g.db_ui_tmp_query_location = vim.fn.stdpath("data") .. "/dadbod_ui/tmp"
			
			-- Keymaps
			vim.api.nvim_set_keymap("n", "<leader>du", "<cmd>DBUIToggle<CR>", { noremap = true, silent = true, desc = "Toggle DB UI" })
			
			-- Add a helper command to easily set the current buffer's database connection
			vim.api.nvim_create_user_command("DBConnect", function(opts)
				vim.b.db = opts.args
				vim.notify("Connected buffer to " .. opts.args, vim.log.levels.INFO)
			end, { nargs = 1, desc = "Set b:db for the current buffer (e.g. :DBConnect sqlite:my_db.sqlite)" })
		end,
		config = function()
			-- Setup autocomplete for sql files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					require("cmp").setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
							{ name = "nvim_lsp" },
							{ name = "buffer" },
							{ name = "luasnip" },
						},
					})
				end,
			})
		end,
	},
}
