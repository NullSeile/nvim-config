return {
    "r4ppz/lspeek.nvim",
    opts = {
        window = {
            width = 70,
            height = 15,
            border = "single", -- double | rounded | solid | shadow

            -- Window-local options applied to the preview window.
            win_opts = {
                -- Examples:
                -- signcolumn = "yes",
                -- number = true,
                -- relativenumber = true,
            },
        },

        -- Limits the number of stacked preview windows.
        stack_limit = 5,

        -- LSP can return multiple definitions
        -- (e.g., overloaded functions or multiple clients).
        -- false = open vim.ui.select to pick one (pairs well with a picker plugin).
        -- true  = skip the picker and preview the first result.
        select_first = false,

        -- Keymaps available inside the preview window.
        keymaps = {
            close = "q", -- close preview
            split = "s", -- open target in horizontal split
            vsplit = "v", -- open target in vertical split
            enter = "<CR>", -- open target in current window
            tab = "t", -- open target in new tab
            prev = "[", -- go to previous preview
            next = "]", -- go to next preview
        },
    },

    keys = {
        {
            "gpd",
            function()
                require("lspeek").peek_definition()
            end,
            desc = "Peek Definition (lspeek)",
        },
        {
            "gpt",
            function()
                require("lspeek").peek_type_definition()
            end,
            desc = "Peek Type Definition (lspeek)",
        },
    },
}
