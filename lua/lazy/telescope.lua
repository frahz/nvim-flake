return {
    { "telescope-fzf-native.nvim" },
    {
        "telescope.nvim",
        cmd = "Telescope",
        after = function()
            local telescope = require("telescope")

            telescope.setup({
                defaults = {
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.65,
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",

                    }
                }
            })
            telescope.load_extension("fzf")
        end,
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>",  mode = "n" },
            { "<leader>fg", "<cmd>Telescope git_files<CR>",   mode = "n" },
            { "<leader>fw", "<cmd>Telescope live_grep<CR>",   mode = "n" },
            { "<leader>fh", "<cmd>Telescope buffers<CR>",     mode = "n" },
            { "<leader>fs", "<cmd>Telescope grep_string<CR>", mode = "n" },
            { "<leader>fo", "<cmd>Telescope oldfiles<CR>",    mode = "n" },
            { "<leader>fc", "<cmd>Telescope git_commits<CR>", mode = "n" },
            { "<leader>fd", "<cmd>Telescope diagnostics<CR>", mode = "n" },
            { "<leader>k",  "<cmd>Telescope keymaps<CR>",     mode = "n" }
        },
    }
}
