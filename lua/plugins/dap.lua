return {
    'mfussenegger/nvim-dap',
    dependencies = {
        {
            'igorlfs/nvim-dap-view',
            lazy = false,
            version = '1.*',
            opts = {
                auto_toggle = 'keep_terminal',
                windows = {
                    size = 0.5,
                    position = 'right',
                    terminal = {
                        size = 0.25,
                        position = 'below',
                        hide = {},
                    },
                },
            },
        },
        { 'mfussenegger/nvim-dap-python', config = function() require('dap-python').setup 'uv' end },
    },
    keys = {
        { '<leader>db', function() require('dap').toggle_breakpoint() end, mode = 'n', desc = 'Toggle Breakpoint' },
        { '<leader>dc', function() require('dap').continue() end, mode = 'n', desc = 'Continue' },
        { '<leader>di', function() require('dap').step_into() end, mode = 'n', desc = 'Step Into' },
        { '<leader>do', function() require('dap').step_over() end, mode = 'n', desc = 'Step Over' },
        { '<leader>dvv', function() require('dap-view').toggle() end, mode = 'n', desc = 'Toggle DapView' },
        {
            '<leader>dvw',
            function() require('dap-view').jump_to_view 'watches' end,
            mode = 'n',
            desc = 'View Watches',
        },
        { '<leader>dvs', function() require('dap-view').jump_to_view 'scopes' end, mode = 'n', desc = 'View Scopes' },
        {
            '<leader>dve',
            function() require('dap-view').jump_to_view 'exceptions' end,
            mode = 'n',
            desc = 'View Exceptions',
        },
        {
            '<leader>dvb',
            function() require('dap-view').jump_to_view 'breakpoints' end,
            mode = 'n',
            desc = 'View Breakpoints',
        },
        { '<leader>dvr', function() require('dap-view').jump_to_view 'repl' end, mode = 'n', desc = 'View Repl' },
        { '<leader>dvc', function() require('dap-view').jump_to_view 'console' end, mode = 'n', desc = 'View Console' },
        { '<leader>dvt', function() require('dap-view').jump_to_view 'threads' end, mode = 'n', desc = 'View Threads' },
        {
            '<leader>dvi',
            function() require('dap-view').jump_to_view 'sessions' end,
            mode = 'n',
            desc = 'View Sessions',
        },
    },
}
