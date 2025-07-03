return {
    "oil.nvim",
    -- before = function()
    --     lzn.trigger_load("nvim-treesitter")
    -- end,
    after = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            },
            float = {
                padding = 5,
            },
            keymaps = {
                ["<leader>o"] = "actions.close",
            }
        })
    end,
    keys = {
        {
            "<leader>o",
            ":lua require('oil').open_float()<CR>",
            desc = "Open Oil Floating Window",
            silent = true
        },
    },

}
