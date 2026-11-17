return {
    "github/copilot.vim",
    config = function()
        vim.keymap.set('n', '<leader>tc', function()
            if vim.fn['copilot#Enabled']() == 1 then
                vim.cmd('Copilot disable')
                print("Copilot disabled")
            else
                vim.cmd('Copilot enable')
                print("Copilot enabled")
            end
        end, { desc = "Toggle Copilot" })
    end,
}
