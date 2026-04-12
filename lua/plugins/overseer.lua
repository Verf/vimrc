return {
    'stevearc/overseer.nvim',
    event = 'VeryLazy',
    keys = {
        { '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Run Task' },
        { '<leader>ot', '<cmd>OverseerToggle<cr>', desc = 'Toggle Task List' },
    },
    opts = {
        strategy = 'terminal',
        task_list = {
            direction = 'right',
            min_width = 40,
            max_width = 50,
            default_detail = 1,
        },
        -- VSCode-like
        component_aliases = {
            default = {
                'on_exit_set_status',
                'on_complete_notify',
                { 'on_complete_dispose', statuses = { 'SUCCESS', 'FAILURE' } },
                'on_output_parse',
                'on_result_diagnostics',
            },
        },
    },
}
