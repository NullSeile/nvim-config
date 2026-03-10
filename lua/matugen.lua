local M = {}

local known_themes = {
    ["kanagawa"] = {
        base09 = "#7e9cd8",
        base0A = "#c0a36e",
        base0B = "#76946a",
    },
    ["kanagawa-dragon"] = {
        base09 = "#8ba4b0",
        base0A = "#c4b28a",
        base0B = "#8a9a7b",
    },
    ["rose-pine"] = {
        base09 = "#31748f",
        base0A = "#9ccfd8",
        base0B = "#ebbcba",
    },
    ["rose-pine-moon"] = {
        base09 = "#3e8fb0",
        base0A = "#9ccfd8",
        base0B = "#ea9a97",
    },
    ["catppuccin"] = {
        base09 = "#94e2d5",
        base0A = "#fab387",
        base0B = "#cba6f7",
    },
    ["gruvbox"] = {
        base09 = "#83a598",
        base0A = "#fabd2f",
        base0B = "#b8bb26",
    },
}

local function is_same_theme(colors, theme_colors)
    for key, value in pairs(theme_colors) do
        if colors[key] ~= value then
            return false
        end
    end
    return true
end

function M.setup()
    local colors = {
        -- Background tones
        base00 = "#1f1f28", -- Default Background
        base01 = "#2a2a37", -- Lighter Background (status bars)
        base02 = "#333343", -- Selection Background
        base03 = "#676785", -- Comments, Invisibles
        -- Foreground tones
        base04 = "#717c7c", -- Dark Foreground (status bars)
        base05 = "#c8c093", -- Default Foreground
        base06 = "#c8c093", -- Light Foreground
        base07 = "#c8c093", -- Lightest Foreground
        -- Accent colors
        base08 = "#c34043", -- Variables, XML Tags, Errors
        base09 = "#7e9cd8", -- Integers, Constants
        base0A = "#c0a36e", -- Classes, Search Background
        base0B = "#76946a", -- Strings, Diff Inserted
        base0C = "#96b1e9", -- Regex, Escape Chars
        base0D = "#ade996", -- Functions, Methods
        base0E = "#e9cb96", -- Keywords, Storage
        base0F = "#430d0e", -- Deprecated, Embedded Tags
    }
    for theme_name, theme_colors in pairs(known_themes) do
        if is_same_theme(colors, theme_colors) then
            vim.cmd.colorscheme(theme_name)
            return
        end
    end

    require("base16-colorscheme").setup(colors)
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
    "sigusr1",
    vim.schedule_wrap(function()
        package.loaded["matugen"] = nil
        require("matugen").setup()
    end)
)

return M
