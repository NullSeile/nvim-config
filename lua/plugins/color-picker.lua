return {
    "uga-rosa/ccc.nvim",
    lazy = false,
    opts = { -- highlight_mode = 'virtual',
        highlighter = {
            auto_enable = true,
        },
    },
    keys = {
        { "<leader>cp", "<cmd>CccPick<cr>", mode = "n", desc = "[C]olor [P]icker" },
    },
    -- config = function ()
    --     vim.keymap.set("n", )
    -- end
    -- config = function()
    --     require("ccc").setup({
    --         -- highlight_mode = 'virtual',
    --         highlighter = {
    --             auto_enable = true,
    --         },
    --     })
    -- end,
}
