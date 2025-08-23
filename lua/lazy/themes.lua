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
                    native_lsp = {
                        enabled = true,
                        inlay_hints = { background = false },
                    },
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end
    },
}
