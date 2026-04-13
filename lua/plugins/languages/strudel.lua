return {
    "gruvw/strudel.nvim",
    build = "npm ci",
    config = function()
        require("strudel").setup()
        local str = require("strudel")
        vim.keymap.set('n', '<C-CR>', str.update)
        -- vim.keymap.set('n', '<C-CR>', str.launch)
        vim.keymap.set('n', '<C-Space>', str.toggle)
    end,
}
