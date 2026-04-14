return {
    'stevearc/overseer.nvim',
    event = 'VeryLazy',
    keys = {
        { '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Run Task' },
        { '<leader>ot', '<cmd>OverseerToggle<cr>', desc = 'Toggle Task List' },
        { '<leader>ol', '<cmd>OverseerRestartLast<cr>', desc = 'Restart Last Task' },
    },
    config = function()
        require('overseer').setup {
            strategy = 'terminal',
            task_list = {
                direction = 'left',

                min_width = { 20, 0.15 },
                max_width = { 35, 0.25 },

                render = require('overseer.render').format_standard,
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
        }

        vim.api.nvim_create_user_command('OverseerRestartLast', function()
            local overseer = require 'overseer'
            local task_list = require 'overseer.task_list'
            local tasks = overseer.list_tasks {
                status = {
                    overseer.STATUS.SUCCESS,
                    overseer.STATUS.FAILURE,
                    overseer.STATUS.CANCELED,
                },
                sort = task_list.sort_finished_recently,
            }
            if vim.tbl_isempty(tasks) then
                vim.notify('No tasks found', vim.log.levels.WARN)
            else
                local most_recent = tasks[1]
                overseer.run_action(most_recent, 'restart')
            end
        end, {})
    end,
}
