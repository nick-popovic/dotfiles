return {
    -- Debugging
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "williamboman/mason.nvim",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("nvim-dap-virtual-text").setup()

            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Key mappings for debugging
            vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>lua require("dap").continue()<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>dso', '<cmd>lua require("dap").step_over()<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>dsi', '<cmd>lua require("dap").step_into()<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>dsout', '<cmd>lua require("dap").step_out()<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>dr', '<cmd>lua require("dap").repl.open()<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua require("dap").run_last()<CR>', { noremap = true, silent = true })

            -- Adapters
            dap.adapters.codelldb = {
                type = 'server',
                port = "${port}",
                executable = {
                    command = "codelldb",
                    args = { "--port", "${port}" },
                }
            }

            dap.adapters.delve = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "dlv",
                    args = { "dap", "-l", "127.0.0.1:${port}" },
                }
            }

            dap.adapters.java = {
                type = 'server',
                port = "${port}",
                executable = {
                    command = "java-debug-adapter",
                    args = { "--port", "${port}" },
                }
            }
            
            dap.adapters.lua = {
                type = 'server',
                port = "${port}",
                executable = {
                    command = "one-small-step-for-vimkind",
                    args = { "--port", "${port}" },
                }
            }

            -- Configurations
            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
            }

            dap.configurations.c = dap.configurations.cpp

            dap.configurations.go = {
                {
                    type = "delve",
                    name = "Debug",
                    request = "launch",
                    program = "${fileDirname}",
                    mode = "debug",
                },
            }

            dap.configurations.java = {
                {
                    type = "java",
                    name = "Debug (Attach)",
                    request = "attach",
                    hostName = "localhost",
                    port = 5005,
                },
            }

            dap.configurations.lua = {
                {
                    type = 'lua',
                    request = 'launch',
                    name = 'Launch file',
                    program = {
                        lua = 'lua',
                        file = '${file}'
                    }
                }
            }
        end,
    },
}
