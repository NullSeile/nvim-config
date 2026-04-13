return {
    {
        'goerz/jupytext.nvim',
        version = '0.2.0',
        opts = {},  -- see Options
    },
    {
        "3rd/image.nvim",
        opts = {
            backend = "kitty",
            integrations = {},
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
        -- version = "1.1.0", -- or comment out for latest
    },
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        build = ":UpdateRemotePlugins",
        dependencies = { "3rd/image.nvim" },
        init = function()
            -- this is an example, not a default. Please see the readme for more configuration options
            -- vim.g.molten_output_win_max_height = 12
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_use_border_highlights = true

        end,
    },
    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            "jmbuhr/otter.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("quarto").setup({
                codeRunner = {
                    enabled = true,
                    default_method = "molten",
                },
            })
            local runner = require("quarto.runner")
            vim.keymap.set("n", "<localleader>rc", runner.run_cell,  { desc = "run cell", silent = true })
            vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
            vim.keymap.set("n", "<localleader>rA", runner.run_all,   { desc = "run all cells", silent = true })
            vim.keymap.set("n", "<localleader>rl", runner.run_line,  { desc = "run line", silent = true })
            vim.keymap.set("v", "<localleader>r",  runner.run_range, { desc = "run visual range", silent = true })
            vim.keymap.set("n", "<localleader>RA", function()
                runner.run_all(true)
            end, { desc = "run all cells of all languages", silent = true })
        end,
    }
}
