return {
    'stevearc/overseer.nvim',
    event = 'VeryLazy',
    keys = {
        { '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Run Task' },
        { '<leader>ot', '<cmd>OverseerToggle<cr>', desc = 'Toggle Task List' },
        { '<leader>oa', '<cmd>OverseerQuickAction<cr>', desc = 'Task Quick Action' },
        { '<leader>ol', '<cmd>OverseerLoadBundle<cr>', desc = 'Load Task Bundle' },
    },
    opts = {
        strategy = 'terminal', -- 推荐：用内置 terminal（干净、支持 Quickfix）
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
