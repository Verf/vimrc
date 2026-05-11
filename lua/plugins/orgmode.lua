return {
    'nvim-orgmode/orgmode',
    dependencies = { 'akinsho/org-bullets.nvim', 'chipsenkbeil/org-roam.nvim' },
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
        local note_dir = vim.env.NOTE_TAKING_DIR
        local agenda_dir = note_dir .. 'agenda/'
        local roam_dir = note_dir .. 'roam/'
        -- 确保目录存在
        local org_dirs = { note_dir, agenda_dir, roam_dir }
        for _, path in ipairs(org_dirs) do
            local expanded_path = vim.fn.expand(path)
            if vim.fn.isdirectory(expanded_path) == 0 then vim.fn.mkdir(expanded_path, 'p') end
        end

        require('orgmode.utils.treesitter.install').compilers = { 'zig' }
        require('orgmode').setup {
            org_agenda_files = {
                note_dir .. '*.org',
                agenda_dir .. '*.org',
            },
            org_default_notes_file = note_dir .. 'refile.org',
            org_startup_folded = 'inherit', -- 继承neovim的folded配置
            -- 自定义任务流状态 (使用 '|' 分隔未完成与已完成状态)
            org_todo_keywords = { 'TODO(t)', 'DOING(i)', 'WAITING(w)', '|', 'DONE(d)', 'CANCELED(c)' },
            -- 配置capture模板
            org_capture_templates = {
                -- 待办管理
                t = {
                    description = 'Task',
                    template = '* TODO %?\n  SCHEDULED: %T\n',
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
        require('org-roam').setup {
            directory = roam_dir,
        }

        vim.lsp.enable 'org'
    end,
}
