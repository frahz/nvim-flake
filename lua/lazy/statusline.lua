local function shiftwidth()
    return "󰌒  " .. vim.api.nvim_get_option_value("shiftwidth", {})
end

vim.opt.fillchars = {
    stl = "─",
    stlnc = "─",
}

return {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function()
        local mocha = require("catppuccin.palettes").get_palette("mocha")
        local theme = {
            normal = {
                a = { bg = mocha.base, fg = mocha.text },
                b = { bg = mocha.base, fg = mocha.text },
                c = { bg = mocha.base, fg = mocha.text },
            },
            inactive = {
                a = { bg = mocha.base, fg = mocha.text },
                b = { bg = mocha.base, fg = mocha.text },
                c = { bg = mocha.base, fg = mocha.text },
            },
        }
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = theme,
                section_separators = { left = "──", right = "──" },
                component_separators = { left = "──", right = "──" },
                padding = 0,
            },
            sections = {
                lualine_a = {},
                lualine_b = {
                    {
                        "mode",
                        padding = 1,
                    },
                    {
                        "branch",
                        icon = { "", color = { fg = mocha.lavender } },
                        padding = 1,
                    },
                    {
                        "diff",
                        padding = 1,
                    },
                    {
                        "diagnostics",
                        padding = 1,
                    },
                },
                lualine_c = {
                    "%=",
                    {
                        "filetype",
                        colored = false,
                        icon_only = true,
                        separator = "∙",
                        padding = 1,
                    },
                    {
                        "filename",
                        file_status = true,
                        newfile_status = false,
                        path = 4,
                        padding = 1,
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {
                    {
                        "progress",
                        padding = 1,
                    },
                    {
                        "location",
                        padding = 1,
                    },
                    {
                        shiftwidth,
                        padding = 1,
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            extensions = {}
        })
    end
}
