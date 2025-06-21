return {
    {
        "nvim-treesitter",
        after = function()
            require("nvim-treesitter.configs").setup({
                auto_install = false,
                highlight = {
                    enable = true,
                },
            })
        end
    },
    { "nvim-ts-context-commentstring" },
    {
        "indent-blankline.nvim",
        event = "DeferredUIEnter",
        before = function()
            LZN.trigger_load("nvim-treesitter")
        end,
        after = function()
            require("ibl").setup({
                indent = { char = "▏" },
                exclude = {
                    filetypes = {
                        "alpha", "help", "terminal", "packer", "lspinfo", "TelescopePrompt", "TelescopeResults"
                    },
                },
            })
        end
    }
}
