return {
    'mfussenegger/nvim-dap',
    dependencies = {
        { 'igorlfs/nvim-dap-view', lazy = false, version = '1.*', opts = {} },
        { 'theHamsta/nvim-dap-virtual-text', opts = {} },
        { 'mfussenegger/nvim-dap-python', config = function() require('dap-python').setup 'uv' end },
    },
    keys = {
        { '<leader>db', function() require('dap').toggle_breakpoint() end, mode = 'n', desc = 'Toggle Breakpoint' },
        { '<leader>dc', function() require('dap').continue() end, mode = 'n', desc = 'Continue' },
        { '<leader>di', function() require('dap').step_into() end, mode = 'n', desc = 'Step Into' },
        { '<leader>do', function() require('dap').step_over() end, mode = 'n', desc = 'Step Over' },
    },
}
