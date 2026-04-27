return {
    'milanglacier/minuet-ai.nvim',
    config = function()
        require('minuet').setup {
            virtualtext = {
                auto_trigger_ft = {},
                keymap = {
                    accept = '<C-Y>',
                    accept_line = '<C-y>',
                    prev = '<C-[>',
                    next = '<C-]>',
                    dismiss = '<C-c>',
                },
            },
            provider = 'openai_fim_compatible',
            provider_options = {
                openai_fim_compatible = {
                    api_key = 'MINUET_DEEPSEEK_API_KEY',
                    name = 'DeepSeek-v4-flash',
                },
            },
        }
    end,
}
