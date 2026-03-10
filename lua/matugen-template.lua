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
        base00 = "{{colors.surface.default.hex}}", -- Default Background
        base01 = "{{colors.surface_container.default.hex}}", -- Lighter Background (status bars)
        base02 = "{{colors.surface_container_high.default.hex}}", -- Selection Background
        base03 = "{{colors.outline.default.hex}}", -- Comments, Invisibles
        -- Foreground tones
        base04 = "{{colors.on_surface_variant.default.hex}}", -- Dark Foreground (status bars)
        base05 = "{{colors.on_surface.default.hex}}", -- Default Foreground
        base06 = "{{colors.on_surface.default.hex}}", -- Light Foreground
        base07 = "{{colors.on_background.default.hex}}", -- Lightest Foreground
        -- Accent colors
        base08 = "{{colors.error.default.hex}}", -- Variables, XML Tags, Errors
        base09 = "{{colors.tertiary.default.hex}}", -- Integers, Constants
        base0A = "{{colors.secondary.default.hex}}", -- Classes, Search Background
        base0B = "{{colors.primary.default.hex}}", -- Strings, Diff Inserted
        base0C = "{{colors.tertiary_fixed_dim.default.hex}}", -- Regex, Escape Chars
        base0D = "{{colors.primary_fixed_dim.default.hex}}", -- Functions, Methods
        base0E = "{{colors.secondary_fixed_dim.default.hex}}", -- Keywords, Storage
        base0F = "{{colors.error_container.default.hex}}", -- Deprecated, Embedded Tags
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
