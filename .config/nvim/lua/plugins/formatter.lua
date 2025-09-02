return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        c = { "clang_format" },
        go = { "gofmt" },
        java = { "google_java_format" },
        sh = { "shfmt" },

        -- For web languages, prettier is the standard
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
      },
    },
    -- Add a keymap to format the buffer
    keys = {
      {
        "<leader><leader>",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "n",
        desc = "Format buffer",
      },
      {
        "<leader>fa",
        function()
          local command = "find . -name '*.lua' -exec stylua {} + 2>/dev/null; " ..
                        "find . -name '*.py' -exec black {} + 2>/dev/null; " ..
                        "find . -name '*.c' -exec clang-format -i {} + 2>/dev/null; " ..
                        "find . -name '*.h' -exec clang-format -i {} + 2>/dev/null; " ..
                        "find . -name '*.go' -exec gofmt -w {} + 2>/dev/null; " ..
                        "find . -name '*.java' -exec google-java-format -i {} + 2>/dev/null; " ..
                        "find . -name '*.sh' -exec shfmt -w {} + 2>/dev/null; " ..
                        "find . -name '*.js' -exec prettier -w {} + 2>/dev/null; " ..
                        "find . -name '*.ts' -exec prettier -w {} + 2>/dev/null; " ..
                        "find . -name '*.jsx' -exec prettier -w {} + 2>/dev/null; " ..
                        "find . -name '*.tsx' -exec prettier -w {} + 2>/dev/null; " ..
                        "find . -name '*.vue' -exec prettier -w {} + 2>/dev/null; " ..
                        "find . -name '*.css' -exec prettier -w {} + 2>/dev/null; " ..
                        "find . -name '*.scss' -exec prettier -w {} + 2>/dev/null; " ..
                        "find . -name '*.html' -exec prettier -w {} + 2>/dev/null; " ..
                        "find . -name '*.json' -exec prettier -w {} + 2>/dev/null; " ..
                        "find . -name '*.yaml' -exec prettier -w {} + 2>/dev/null; " ..
                        "find . -name '*.yml' -exec prettier -w {} + 2>/dev/null; " ..
                        "find . -name '*.md' -exec prettier -w {} + 2>/dev/null; " ..
                        "find . -name '*.graphql' -exec prettier -w {} + 2>/dev/null"
          vim.fn.system(command)
          vim.notify("Formatted files in project directory.", vim.log.levels.INFO, { title = "Formatter" })
        end,
        mode = "n",
        desc = "Format all files",
      },
    },
  },
}
