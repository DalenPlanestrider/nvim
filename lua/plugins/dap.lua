return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            -- UI for nvim-dap (the actual debugging interface)
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
            -- Show variable values inline as virtual text
            'theHamsta/nvim-dap-virtual-text',
            -- Install debug adapters via mason
            'williamboman/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim',
        },
        keys = {
            { '<F5>',       function() require('dap').continue() end,          desc = 'DAP: Continue / start' },
            { '<F10>',      function() require('dap').step_over() end,         desc = 'DAP: Step over' },
            { '<F11>',      function() require('dap').step_into() end,         desc = 'DAP: Step into' },
            { '<F12>',      function() require('dap').step_out() end,          desc = 'DAP: Step out' },
            { '<leader>b',  function() require('dap').toggle_breakpoint() end, desc = 'DAP: Toggle breakpoint' },
            {
                '<leader>B',
                function()
                    require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
                end,
                desc = 'DAP: Conditional breakpoint',
            },
            { '<leader>dr', function() require('dap').repl.toggle() end,       desc = 'DAP: Toggle REPL' },
            { '<leader>dl', function() require('dap').run_last() end,          desc = 'DAP: Run last' },
            { '<leader>dq', function() require('dap').terminate() end,         desc = 'DAP: Terminate' },
            { '<leader>du', function() require('dapui').toggle() end,          desc = 'DAP: Toggle UI' },
            {
                '<leader>dh',
                function() require('dapui').eval() end,
                mode = { 'n', 'v' },
                desc = 'DAP: Evaluate under cursor',
            },
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            local mason_bin = vim.fn.stdpath('data') .. '/mason/bin/'

            -- Install adapters (debugpy, codelldb, js-debug-adapter)
            require('mason-nvim-dap').setup({
                ensure_installed = { 'python', 'codelldb', 'js' },
                automatic_installation = false,
            })

            -----------------------------------------------------------------
            -- Adapters
            -----------------------------------------------------------------
            -- Python (debugpy)
            dap.adapters.python = {
                type = 'executable',
                command = mason_bin .. 'debugpy-adapter',
            }

            -- C / C++ / Rust (codelldb)
            dap.adapters.codelldb = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = mason_bin .. 'codelldb',
                    args = { '--port', '${port}' },
                },
            }

            -- JS / TS (js-debug-adapter, VS Code's debugger)
            dap.adapters['pwa-node'] = {
                type = 'server',
                host = '127.0.0.1',
                port = '${port}',
                executable = {
                    command = mason_bin .. 'js-debug-adapter',
                    args = { '${port}' },
                },
            }

            -----------------------------------------------------------------
            -- Configurations
            -----------------------------------------------------------------
            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = 'Launch file',
                    program = '${file}',
                    cwd = '${workspaceFolder}',
                    -- Prefer an active virtualenv, else system python
                    pythonPath = function()
                        local venv = os.getenv('VIRTUAL_ENV')
                        if venv then
                            return venv .. '/bin/python'
                        end
                        return vim.fn.exepath('python3')
                    end,
                },
            }

            dap.configurations.cpp = {
                {
                    name = 'Launch file',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
            }
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp

            for _, lang in ipairs({ 'javascript', 'typescript' }) do
                dap.configurations[lang] = {
                    {
                        type = 'pwa-node',
                        request = 'launch',
                        name = 'Launch file',
                        program = '${file}',
                        cwd = '${workspaceFolder}',
                    },
                    {
                        type = 'pwa-node',
                        request = 'attach',
                        name = 'Attach to process',
                        processId = require('dap.utils').pick_process,
                        cwd = '${workspaceFolder}',
                    },
                }
            end

            -----------------------------------------------------------------
            -- UI
            -----------------------------------------------------------------
            dapui.setup()
            require('nvim-dap-virtual-text').setup()

            -- Auto open/close the UI with the debug session
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end

            -- Nicer signs in the gutter
            vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
            vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn' })
            vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticInfo', linehl = 'CursorLine' })
        end,
    },
}
