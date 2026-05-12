return {
    'nvim-orgmode/orgmode',
    dependencies = { 'akinsho/org-bullets.nvim' },
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
        local note_dir = vim.env.NOTE_TAKING_DIR

        require('orgmode.utils.treesitter.install').compilers = { 'zig' }
        require('orgmode').setup {
            org_agenda_files = note_dir .. '**/*.org',
            org_default_notes_file = note_dir .. 'refile.org',
            org_startup_folded = 'inherit', -- 继承neovim的folded配置
            -- 配置capture模板
            org_capture_templates = {
                -- 待办管理
                t = {
                    description = 'Task',
                    template = '* TODO %?\n  DEADLINE: %T\n',
                    target = note_dir .. 'todos.org',
                },
                -- 会议记录
                m = {
                    description = 'Meeting',
                    template = '* %U %^{会议标题}\n\n** 纪要\n%?\n\n** 任务\n- [ ] ',
                    target = note_dir .. 'meetings.org',
                },
                -- 碎片化记录
                j = {
                    description = 'Journal',
                    template = '* %U %?\n',
                    target = note_dir .. 'refile.org',
                },
            },
            mappings = {
                agenda = {
                    org_agenda_goto = false,
                },
                org = {
                    org_cycle = false, -- 避免与<Tab>冲突
                    org_global_cycle = false, -- 避免与<S-Tab>冲突
                    org_return = false, -- 避免<CR>与mini.keymap中<CR>配置冲突
                },
            },
        }
        require('org-bullets').setup()

        vim.lsp.enable 'org'
    end,
}
