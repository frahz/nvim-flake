return {
    {
        "guess-indent.nvim",
        after = function()
            require("guess-indent").setup({})
        end,
    },
    {
        "typst-preview.nvim",
        ft = "typst",
        after = function()
            require("typst-preview").setup({
                open_cmd = 'firefox %s --class typst-preview',
                dependencies_bin = {
                    ['tinymist'] = "${pkgs.tinymist}/bin/tinymist",
                    ['websocat'] = "${pkgs.websocat}/bin/websocat"
                },
            })
        end,
    },
    {
        "tiny-inline-diagnostic.nvim",
        event = "DeferredUIEnter",
        after = function ()
            require("tiny-inline-diagnostic").setup({
                preset = "classic",
            })
        end
    }
}
