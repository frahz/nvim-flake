return {
    {
        "nvim-treesitter",
        event = "DeferredUIEnter",
        after = function()
            require("nvim-treesitter.configs").setup({
                auto_install = false,
                highlight = { enable = true },
            })
        end
    },
    { "nvim-ts-context-commentstring" },
    { "rainbow-delimiters.nvim", },
}
