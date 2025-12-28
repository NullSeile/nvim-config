return { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
        -- require("mini.trailspace").setup()
        -- vim.api.nvim_create_autocmd("FileType", {
        --     pattern = { "starter", "alpha", "dashboard", "snacks_dashboard" },
        --     callback = function()
        --         vim.b.minitrailspace_disable = true
        --     end,
        -- })

        require("mini.indentscope").setup({
            draw = {
                -- delay = 0,
                animation = function(n)
                    return 20 / n
                end,
            },
            symbol = "▏",
        })
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Comment" })
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
                vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Comment" })
            end,
        })

        require("mini.splitjoin").setup()

        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup()

        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        local statusline = require("mini.statusline")
        -- set use_icons to true if you have a Nerd Font
        statusline.setup({ use_icons = vim.g.have_nerd_font })

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            return "%2l:%-2v"
        end

        require("mini.files").setup()

        local current_file = ""
        -- local get_current_file = function()
        --   -- print('Current file: ' .. current_file)
        --   vim.notify('Current file: ' .. current_file, 5)
        --   return current_file
        -- end
        vim.keymap.set({ "n", "v" }, "<leader>f", function(...)
            if not MiniFiles.close() then
                current_file = vim.api.nvim_buf_get_name(0)
                MiniFiles.open()
            end
        end)

        -- Set focused directory as current working directory
        local set_cwd = function()
            local path = (MiniFiles.get_fs_entry() or {}).path
            if path == nil then
                return vim.notify("Cursor is not on valid entry")
            end
            vim.fn.chdir(vim.fs.dirname(path))
        end

        local map_split = function(buf_id, lhs, direction)
            local rhs = function()
                -- Make new window and set it as target
                local cur_target = MiniFiles.get_explorer_state().target_window
                local new_target = vim.api.nvim_win_call(cur_target, function()
                    vim.cmd(direction .. " split")
                    return vim.api.nvim_get_current_win()
                end)

                MiniFiles.set_target_window(new_target)
                MiniFiles.go_in()
            end

            -- Adding `desc` will result into `show_help` entries
            local desc = "Split " .. direction
            vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
        end

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesBufferCreate",
            callback = function(args)
                local buf_id = args.data.buf_id
                map_split(buf_id, "<C-s>", "belowright horizontal")
                map_split(buf_id, "<C-v>", "belowright vertical")

                local b = args.data.buf_id
                vim.keymap.set("n", ".", set_cwd, { buffer = b, desc = "Set cwd" })
                vim.keymap.set("n", "<leader><leader>", function()
                    MiniFiles.open(current_file)
                    MiniFiles.reveal_cwd()
                end, { buffer = b, desc = "Close" })
            end,
        })
        local set_mark = function(id, path, desc)
            MiniFiles.set_bookmark(id, path, { desc = desc })
        end

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesExplorerOpen",
            callback = function()
                set_mark("c", vim.fn.stdpath("config"), "Config") -- path
                set_mark("w", vim.fn.getcwd, "Working directory") -- callable
                set_mark("~", "~", "Home directory")
                -- set_mark(' ', get_current_file, 'Current file')
            end,
        })
    end,
}
