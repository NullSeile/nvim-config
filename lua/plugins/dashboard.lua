return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = {
        theme = "doom",
        preview = {
            command = "python3 " .. vim.fn.stdpath("config") .. "/header.py",
            file_path = vim.fn.stdpath("config") .. "/art.txt",
            file_width = 71,
            file_height = 13,
        },
        config = {
            center = {},
        },
    },
}
