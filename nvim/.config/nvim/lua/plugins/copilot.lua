return {
	"github/copilot.vim",
	config = function()
		-- Wait for VimEnter to ensure Copilot is fully loaded before disabling
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				vim.cmd("Copilot disable")
			end,
		})

		-- Initialize global state for lualine
		_G.copilot_enabled = false

		vim.keymap.set("n", "<leader>c", function()
			_G.copilot_enabled = not _G.copilot_enabled
			if _G.copilot_enabled then
				vim.cmd("Copilot enable")
			else
				vim.cmd("Copilot disable")
			end
			-- Refresh lualine if available
			local ok, lualine = pcall(require, "lualine")
			if ok then
				lualine.refresh()
			end
		end, { desc = "Toggle Copilot" })
	end,
}
