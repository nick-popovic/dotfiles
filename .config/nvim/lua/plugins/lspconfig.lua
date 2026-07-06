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
				float = {
					border = "rounded",
				},
				-- virtual_text = false, -- Disable virtual text (optional)
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
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
					local _, win_id = vim.diagnostic.open_float(nil, { focusable = false })
					if win_id then
						vim.api.nvim_set_option_value(
							"winhighlight",
							"Normal:CmpDocPmenu,FloatBorder:CmpDocPmenuBorder",
							{ win = win_id }
						)
					end
				end,
			})


			
			-- Manual keymaps to trigger signature help
			vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show Signature Help" })
			vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "Show Signature Help" })

			-- Autocompletion configuration
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Initialize global state for ghost text
			_G.cmp_ghost_text = false

			vim.keymap.set("n", "<leader>g", function()
				_G.cmp_ghost_text = not _G.cmp_ghost_text
				cmp.setup({
					experimental = {
						ghost_text = _G.cmp_ghost_text,
					},
				})
				-- Refresh lualine if available
				local ok, lualine = pcall(require, "lualine")
				if ok then
					lualine.refresh()
				end
			end, { desc = "Toggle Ghost Text" })

			-- Define custom highlight groups for nvim-cmp and ensure they persist across themes
			local function setup_cmp_highlights()
				vim.api.nvim_set_hl(0, "CmpPmenu", { fg = "#cdd6f4", bg = "#1e1e2e" }) -- Catppuccin Macchiato text and background
				vim.api.nvim_set_hl(0, "CmpPmenuBorder", { fg = "#45475a", bg = "#1e1e2e" }) -- Border color
				vim.api.nvim_set_hl(0, "CmpSel", { fg = "NONE", bg = "#45475a" }) -- Selected item background
				-- Highlight groups for documentation windows, with a custom background
				vim.api.nvim_set_hl(0, "CmpDocPmenu", { fg = "#cdd6f4", bg = "#515152" }) -- Light foreground on dark grey background
				vim.api.nvim_set_hl(0, "CmpDocPmenuBorder", { fg = "#ABB2BF", bg = "#515152" }) -- Light grey border on dark grey background
				
				-- A visually friendly, bright pastel red for better contrast against the grey background
				local bright_red = "#ff95a2"
				
				vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = bright_red, strikethrough = true }) 
			
				-- Sync default Neovim floats (like diagnostics) to use the grey background
				vim.api.nvim_set_hl(0, "NormalFloat", { link = "CmpDocPmenu" })
				vim.api.nvim_set_hl(0, "FloatBorder", { link = "CmpDocPmenuBorder" })

				-- Override specific red text elements inside floats to use our new bright red
				vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = bright_red, bg = "#515152" })
				vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = bright_red, bg = "#515152", bold = true })
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
					["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<Esc>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.abort()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Right>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.scroll_docs(4)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<Left>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.scroll_docs(-4)
						else
							fallback()
						end
					end, { "i", "s" }),
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
					ghost_text = _G.cmp_ghost_text,
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

			-- Global mappings for LuaSnip jumping (works better outside of nvim-cmp)
			vim.keymap.set({ "i", "s" }, "<Tab>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					-- Insert a standard Tab character if we are not jumping
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end, { silent = true, desc = "LuaSnip Jump Forward" })

			vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
				end
			end, { silent = true, desc = "LuaSnip Jump Backward" })
		end,
	},
}
