return {
    "chomosuke/typst-preview.nvim",
    dependencies = {
        "windwp/nvim-autopairs",
    },
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    config = function()
        require("typst-preview").setup({
            invert_colors = "never",
        })

        local npairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")

        npairs.add_rules({
            Rule("$", "$", "typst"),

            -- Rule for a pair with left-side ' ' and right side ' '
            Rule(" ", " ")
                -- Pair will only occur if the conditional function returns true
                :with_pair(
                    function(opts)
                        -- We are checking if we are inserting a space in (), [], or {}
                        local pair = opts.line:sub(opts.col - 1, opts.col)
                        return vim.tbl_contains({
                            "$" .. "$",
                        }, pair)
                    end
                )
                :with_move(cond.none())
                :with_cr(cond.none())
                -- We only want to delete the pair of spaces when the cursor is as such: ( | )
                :with_del(
                    function(opts)
                        local col = vim.api.nvim_win_get_cursor(0)[2]
                        local context = opts.line:sub(col - 1, col + 2)
                        return vim.tbl_contains({
                            "$  $",
                        }, context)
                    end
                ),
        })
    end,
}
