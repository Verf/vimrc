return {
    'chrisgrieser/nvim-various-textobjs',
    event = 'VeryLazy',
    keys = {
        {
            'as',
            [[<cmd>lua require("various-textobjs").subword("outer")<cr>]],
            mode = { 'o', 'x' },
            desc = 'Outer Subword',
        },
        {
            'rs',
            [[<cmd>lua require("various-textobjs").subword("inner")<cr>]],
            mode = { 'o', 'x' },
            desc = 'Inner Subword',
        },
        {
            'aq',
            [[<cmd>lua require("various-textobjs").anyQuote("outer")<cr>]],
            mode = { 'o', 'x' },
            desc = 'Outer Quote',
        },
        {
            'rq',
            [[<cmd>lua require("various-textobjs").anyQuote("inner")<cr>]],
            mode = { 'o', 'x' },
            desc = 'Inner Quote',
        },
        {
            'ab',
            [[<cmd>lua require("various-textobjs").anyBracket("outer")<cr>]],
            mode = { 'o', 'x' },
            desc = 'Outer Bracket',
        },
        {
            'rb',
            [[<cmd>lua require("various-textobjs").anyBracket("inner")<cr>]],
            mode = { 'o', 'x' },
            desc = 'Inner Bracket',
        },
        {
            'av',
            [[<cmd>lua require("various-textobjs").value("outer")<cr>]],
            mode = { 'o', 'x' },
            desc = 'Outer Value',
        },
        {
            'rv',
            [[<cmd>lua require("various-textobjs").value("inner")<cr>]],
            mode = { 'o', 'x' },
            desc = 'Inner Value',
        },
        {
            'ak',
            [[<cmd>lua require("various-textobjs").key("outer")<cr>]],
            mode = { 'o', 'x' },
            desc = 'Outer Key',
        },
        {
            'rk',
            [[<cmd>lua require("various-textobjs").key("inner")<cr>]],
            mode = { 'o', 'x' },
            desc = 'Inner Key',
        },
        {
            'an',
            [[<cmd>lua require("various-textobjs").number("outer")<cr>]],
            mode = { 'o', 'x' },
            desc = 'Outer Number',
        },
        {
            'rn',
            [[<cmd>lua require("various-textobjs").number("inner")<cr>]],
            mode = { 'o', 'x' },
            desc = 'Inner Number',
        },
        {
            'q',
            [[<cmd>lua require("various-textobjs").toNextQuotationMark()<cr>]],
            mode = { 'o', 'x' },
            desc = 'Next Quote',
        },
        {
            'c',
            [[<cmd>lua require("various-textobjs").toNextClosingBracket()<cr>]],
            mode = { 'o', 'x' },
            desc = 'Next Bracket',
        },
    },
    opts = {
        keymaps = {
            useDefaults = false,
        },
    },
}
