return {
	-- Mason for managing LSP servers
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ensure_installed = {
					"prettier", -- prettier for web dev
					"stylua", -- stylua for lua
					"black", -- black for python
					"shfmt", -- shfmt for shell
					"clang-format", -- for c
					"google-java-format", -- for java
					"delve", -- for go
					"java-debug-adapter", -- for java
					"java-test", -- for java
					"codelldb", -- for c/c++
					"one-small-step-for-vimkind", -- for lua
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls", "jdtls", "clangd", "sqls" }, -- Add more LSP servers you need
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "Lua 5.3",
						},
						diagnostics = {
							globals = { "bit", "vim", "it", "describe", "before_each", "after_each", "hl" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true), -- Make Neovim runtime files discoverable
							checkThirdParty = false, -- Avoid popping up workspace notifications
						},
						telemetry = {
							enable = false, -- Disable telemetry to avoid sending data
						},
						codeLens = {
							enable = true,
						},
						completion = {
							callSnippet = "Replace",
						},
						doc = {
							privateName = { "^_" },
						},
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = "Disable",
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
					},
				},
			})

			vim.lsp.config("gopls", {
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})

			vim.lsp.config("jdtls", {
				capabilities = capabilities,
			})

			vim.lsp.config("clangd", {
				capabilities = capabilities,
			})

			vim.lsp.config("sqls", {
				capabilities = capabilities,
			})
		end,
	},
}
