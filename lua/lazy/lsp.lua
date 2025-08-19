return {
    {
        "fidget.nvim",
        event = "DeferredUIEnter",
        after = function()
            require("fidget").setup({})
        end
    },
    {
        "crates.nvim",
        event = "BufEnter Cargo.toml",
        before = function()
            LZN.trigger_load("nvim-lspconfig")
        end,
        after = function()
            require("crates").setup({
                lsp = {
                    enabled = true,
                    actions = true,
                    completion = true,
                    hover = true,
                },
            })
        end,
    }
}
