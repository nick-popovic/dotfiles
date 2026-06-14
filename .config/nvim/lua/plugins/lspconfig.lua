return {
	-- LSP Config
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp", -- Completion framework
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
			"hrsh7th/cmp-path", -- Path source for nvim-cmp
			"hrsh7th/cmp-cmdline", -- Cmdline source for nvim-cmp
			"L3MON4D3/LuaSnip", -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- Snippet completion
			"rafamadriz/friendly-snippets", -- Snippet collection
			"hrsh7th/cmp-nvim-lsp-signature-help", -- LSP signature help source
		},
		config = function()
			-- Diagnostic options with signs configured
			vim.diagnostic.config({
				-- virtual_text = false, -- Disable virtual text (optional)
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},
				update_in_insert = true,
				severity_sort = true,
			})

			-- Key mappings for diagnostic navigation
			vim.api.nvim_set_keymap(
				"n",
				"[d",
				"<cmd>lua vim.diagnostic.goto_prev()<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"]d",
				"<cmd>lua vim.diagnostic.goto_next()<CR>",
				{ noremap = true, silent = true }
			)

			-- vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>',
			--     { noremap = true, silent = true })

			vim.api.nvim_set_keymap(
				"n",
				"<leader>q",
				"<cmd>lua vim.diagnostic.setloclist()<CR>",
				{ noremap = true, silent = true }
			)

			local function CopyDiagnostics()
				local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
				if vim.tbl_isempty(diagnostics) then
					vim.notify("No diagnostics on this line", vim.log.levels.INFO)
					return
				end
				local messages = {}
				for _, d in ipairs(diagnostics) do
					table.insert(messages, d.message)
				end
				local message_str = table.concat(messages, "\n")
				vim.fn.setreg("+", message_str)
				vim.notify("Copied " .. #diagnostics .. " diagnostic(s) to clipboard", vim.log.levels.INFO)
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>y",
				"<cmd>lua C			local function CopyDiagnostics()opyDiagnostics()<CR>",
				{ noremap = true, silent = true, desc = "Copy diagnostics on line" }
			)

			-- Show floating diagnostics automatically on hover
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, { focusable = false })
				end,
			})

			-- Autocompletion configuration
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Define custom highlight groups for nvim-cmp and ensure they persist across themes
			local function setup_cmp_highlights()
				vim.api.nvim_set_hl(0, "CmpPmenu", { fg = "#cdd6f4", bg = "#1e1e2e" }) -- Catppuccin Macchiato text and background
				vim.api.nvim_set_hl(0, "CmpPmenuBorder", { fg = "#45475a", bg = "#1e1e2e" }) -- Border color
				vim.api.nvim_set_hl(0, "CmpSel", { fg = "NONE", bg = "#45475a" }) -- Selected item background
				-- Highlight groups for documentation windows, with a custom background
				vim.api.nvim_set_hl(0, "CmpDocPmenu", { fg = "#cdd6f4", bg = "#515152" }) -- Light foreground on dark grey background
				vim.api.nvim_set_hl(0, "CmpDocPmenuBorder", { fg = "#ABB2BF", bg = "#515152" }) -- Light grey border on dark grey background
				vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#E06C75", strikethrough = true }) -- Dark red for deprecated items with strikethrough
			end

			-- Call the function initially
			setup_cmp_highlights()

			-- Set up an autocommand to re-apply highlights whenever the colorscheme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = setup_cmp_highlights,
				desc = "Reapply nvim-cmp custom highlights after colorscheme change",
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = {
					["<Down>"] = cmp.mapping.select_next_item(),
					["<Up>"] = cmp.mapping.select_prev_item(),
					["<Esc>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				completion = {
					completeopt = "menu,menuone,noinsert" .. (true and "" or ",noselect"),
					border = "double",
				},

				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:CmpDocPmenu,FloatBorder:CmpDocPmenuBorder,CursorLine:CmpSel,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:CmpDocPmenu,FloatBorder:CmpDocPmenuBorder,CursorLine:CmpSel,Search:None",
					}),
				},
				experimental = {
					ghost_text = true,
				},
				formatting = {
					format = function(entry, item)
						local widths = {
							abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
							menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
						}

						for key, width in pairs(widths) do
							if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
								item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
							end
						end

						return item
					end,
				},
			})

			-- Use buffer source for `/` in command mode
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline({
					["<Down>"] = {
						c = function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							else
								fallback()
							end
						end,
					},
					["<Up>"] = {
						c = function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							else
								fallback()
							end
						end,
					},
				}),
				sources = {
					{ name = "buffer" },
					{ name = "cmdline" },
				},
			})

			-- Use cmdline & path source for `:` in command mode
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<Down>"] = {
						c = function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							else
								fallback()
							end
						end,
					},
					["<Up>"] = {
						c = function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							else
								fallback()
							end
						end,
					},
				}),
				sources = {
					{ name = "path" },
					{ name = "cmdline" },
				},
			})

			-- Load snippets from friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
