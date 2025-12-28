return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            -- open_mapping = [[<leader>o]],
            start_in_insert = true,
            shell = "fish",
        })
        vim.keymap.set("n", "<leader>o", ":ToggleTerm<Cr>")

        vim.keymap.set("t", "<esc>", function()
            vim.cmd.stopinsert()
        end)
    end,
}
