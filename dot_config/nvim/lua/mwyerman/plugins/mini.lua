return {
    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.pairs").setup()
            require("mini.splitjoin").setup()
            require("mini.diff").setup({
                view = {
                    style = "sign",
                },
            })
            require("mini.hipatterns").setup({
                highlighters = {
                    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                    fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

                    -- Highlight hex color strings (`#rrggbb`) using that color
                    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
                }
            })
            require("mini.surround").setup({
                -- make sure these don't conflict with 's' mapping
                mappings = {
                    add = 'ys',          -- Add surrounding in Normal and Visual modes
                    delete = 'ds',       -- Delete surroundin
                    find = '',           -- Find surrounding (to the right)
                    find_left = '',      -- Find surrounding (to the left)
                    highlight = '',      -- Highlight surrounding
                    replace = 'cs',      -- Replace surrounding
                    update_n_lines = '', -- Update `n_lines`

                    suffix_last = '',    -- Suffix to search with "prev" method
                    suffix_next = '',    -- Suffix to search with "next" method
                },
            })
            require("mini.move").setup({
                mappings = {
                    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                    left = 'H',
                    right = 'L',
                    down = 'J',
                    up = 'K',

                    -- Move current line in Normal mode
                    line_left = '',
                    line_right = '',
                    line_down = '',
                    line_up = '',
                }
            })
        end
    }
}
