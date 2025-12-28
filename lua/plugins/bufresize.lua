return {
    "kwkarlwang/bufresize.nvim",
    config = function()
        require("bufresize").setup({
            resize = {
                trigger_events = { "VimResized" },
            },
        })
    end,
}
