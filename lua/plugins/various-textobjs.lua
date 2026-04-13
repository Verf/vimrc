return {
    'chrisgrieser/nvim-various-textobjs',
    event = 'VeryLazy',
    keys = {
        {
            'as',
            function() require('various-textobjs').subword 'outer' end,
            mode = { 'o', 'x' },
            desc = 'Outer Subword',
        },
        {
            'rs',
            function() require('various-textobjs').subword 'inner' end,
            mode = { 'o', 'x' },
            desc = 'Inner Subword',
        },
        {
            'aq',
            function() require('various-textobjs').anyQuote 'outer' end,
            mode = { 'o', 'x' },
            desc = 'Outer Quote',
        },
        {
            'rq',
            function() require('various-textobjs').anyQuote 'inner' end,
            mode = { 'o', 'x' },
            desc = 'Inner Quote',
        },
        {
            'ab',
            function() require('various-textobjs').anyBracket 'outer' end,
            mode = { 'o', 'x' },
            desc = 'Outer Bracket',
        },
        {
            'rb',
            function() require('various-textobjs').anyBracket 'inner' end,
            mode = { 'o', 'x' },
            desc = 'Inner Bracket',
        },
        {
            'av',
            function() require('various-textobjs').value 'outer' end,
            mode = { 'o', 'x' },
            desc = 'Outer Value',
        },
        {
            'rv',
            function() require('various-textobjs').value 'inner' end,
            mode = { 'o', 'x' },
            desc = 'Inner Value',
        },
        {
            'ak',
            function() require('various-textobjs').key 'outer' end,
            mode = { 'o', 'x' },
            desc = 'Outer Key',
        },
        {
            'rk',
            function() require('various-textobjs').key 'inner' end,
            mode = { 'o', 'x' },
            desc = 'Inner Key',
        },
        {
            'an',
            function() require('various-textobjs').number 'outer' end,
            mode = { 'o', 'x' },
            desc = 'Outer Number',
        },
        {
            'rn',
            function() require('various-textobjs').number 'inner' end,
            mode = { 'o', 'x' },
            desc = 'Inner Number',
        },
        {
            'q',
            function() require('various-textobjs').toNextQuotationMark() end,
            mode = { 'o', 'x' },
            desc = 'Next Quote',
        },
        {
            'B',
            function() require('various-textobjs').toNextClosingBracket() end,
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
