return {
    "smart-splits-nvim/smart-splits.nvim",
    lazy = false,
    dependencies = {
        {
            'smart-splits-nvim/backend-tmux',
            main = 'smart-splits-backend-tmux'
        },
    },
    config = function()
        require("smart-splits").setup({
            mux = {
                backend = 'smart-splits-backend-tmux',
                warn_if_unusable = true,
            },
            move = {
                at_edge = "stop",
                same_row = false,
                float = 'previous',
            },
        })

        vim.keymap.set("n", "<C-Left>", require("smart-splits").resize_left)
        vim.keymap.set("n", "<C-Down>", require("smart-splits").resize_down)
        vim.keymap.set("n", "<C-Up>", require("smart-splits").resize_up)
        vim.keymap.set("n", "<C-Right>", require("smart-splits").resize_right)

        -- moving between splits
        vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
        vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
        vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
        vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
    end,
}
