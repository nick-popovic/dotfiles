return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gs = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Next Hunk" })

				map("n", "[h", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Previous Hunk" })

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
				map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage Hunk" })
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset Hunk" })
				map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
				map("n", "<leader>hb", gs.toggle_current_line_blame, { desc = "Toggle Blame" })
			end,
		})
	end,
}
