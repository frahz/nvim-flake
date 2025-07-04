return {
    {
        "catppuccin-nvim",
        lazy = false,
        priority = 1200,
        after = function()
            require("catppuccin").setup({
                flavour = "mocha",
                no_italic = true,
                integrations = {
                    treesitter = true,
                    blink_cmp = true,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end
    },
}
