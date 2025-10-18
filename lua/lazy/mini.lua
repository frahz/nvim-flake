return {
    {
        "mini.ai",
        event = "BufAdd",
        after = function()
            require("mini.ai").setup()
        end
    },
    {
        "mini.comment",
        event = "DeferredUIEnter",
        after = function()
            require("mini.comment").setup()
        end
    },
    {
        "mini.icons",
        lazy = false,
        priority = 1000,
        after = function()
            local icons = require("mini.icons")
            icons.setup({
                lsp = {
                    ["function"] = { glyph = "󰊕" },
                }
            })
            icons.mock_nvim_web_devicons()
        end
    },
    {
        "mini.indentscope",
        event = "DeferredUIEnter",
        after = function()
            require("mini.indentscope").setup({
                draw = { animation = function() return 5 end },
                options = { try_as_border = true },
                symbol = "│",
            })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "fzf",
                    "help",
                    "ministarter",
                    "notify",
                    "oil",
                    "oil_preview"
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end
    },
    {
        "mini.notify",
        event = "DeferredUIEnter",
        after = function()
            require("mini.notify").setup({
                content = {
                    format = function(notif)
                        if notif.data.source == 'lsp_progress' then return notif.msg end
                        return MiniNotify.default_format(notif)
                    end,
                },
                lsp_progess = { duration_last = 2000 },
                window = {
                    config = function()
                        local has_statusline = vim.o.laststatus > 0
                        local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
                        return {
                            anchor = 'SE',
                            row = vim.o.lines - pad,
                            col = vim.o.columns,
                            border = 'none',
                        }
                    end,
                    winblend = 100,
                    max_width_share = 0.35,
                },
            })
        end
    },
    {
        "mini.pairs",
        event = "InsertEnter",
        after = function()
            require("mini.pairs").setup()
        end
    },
    {
        "mini.splitjoin",
        event = "BufRead",
        after = function()
            local sj = require("mini.splitjoin")
            sj.setup({
                join = {
                    hooks_post = {
                        sj.gen_hook.pad_brackets( { bracket = { "%b{}" } } )
                    }
                }
            })
        end
    },
    {
        "mini.starter",
        event = "VimEnter",
        after = function()
            local starter = require("mini.starter")
            starter.setup({
                header = table.concat({
                    " ⠀⠀⠀⠀⠀⠀⠀⢀⠀⠔⡀⠀⢀⠞⢰⠂⠀⠀⠀⠀⠀⠀⠀ ",
                    " ⠀⠀⠀⠀⠀⠀⠀⢸⠘⢰⡃⠔⠩⠤⠦⠤⢀⡀⠀⠀⠀⠀⠀ ",
                    " ⠀⠀⠀⢀⠄⢒⠒⠺⠆⠈⠀⠀⢐⣂⠤⠄⡀⠯⠕⣒⣒⡀⠀ ",
                    " ⠀⠀⢐⡡⠔⠁⠆⠀⠀⠀⠀⠀⢀⠠⠙⢆⠀⠈⢁⠋⠥⣀⣀ ",
                    " ⠈⠉⠀⣰⠀⠀⠀⠀⡀⠀⢰⣆⢠⠠⢡⡀⢂⣗⣖⢝⡎⠉⠀ ",
                    " ⢠⡴⠛⡇⠀⠐⠀⡄⣡⢇⠸⢸⢸⡇⠂⡝⠌⢷⢫⢮⡜⡀⠀ ",
                    " ⠀⠀⢰⣜⠘⡀⢡⠰⠳⣎⢂⣟⡎⠘⣬⡕⣈⣼⠢⠹⡟⠇⠀ ",
                    " ⠀⠠⢋⢿⢳⢼⣄⣆⣦⣱⣿⣿⣿⣷⠬⣿⣿⣿⣿⠑⠵⠀⠀ ",
                    " ⠀⠀⠀⡜⢩⣯⢝⡀⠁⠀⠙⠛⠛⠃⠀⠈⠛⠛⡿⠀⠀⠀⠀ ",
                    "  ⠀⠀⠀⠀⣿⠢⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀ ",
                    " ⠀⠀⠀⠀⢀⣀⡇⠀⠑⠀⠀⠀⠀⠐⢄⠄⢀⡼⠃⠀⠀⠀⠀ ",
                    " ⠀⠀⠀⠀⢸⣿⣷⣤⣀⠈⠲⡤⣀⣀⠀⡰⠋⠀⠀⠀⠀⠀⠀ ",
                    " ⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣶⣤⣙⣷⣅⡀⠀⠀⠀⠀⠀⠀⠀ ",
                    " ⠀⠀⢀⣾⣿⣿⣿⣿⣻⢿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀ ",
                    " ⠀⡠⠟⠁⠙⠟⠛⠛⢿⣿⣾⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀ ",
                }, "\n"),
                footer = os.date("%B %d, %I:%M %p"),
                items = {
                    { name = "Files",     action = "FzfLua files",     section = "Search", },
                    { name = "Live grep", action = "FzfLua live_grep", section = "Search", },
                    starter.sections.builtin_actions(),
                    starter.sections.recent_files(4, false),
                },
                content_hooks = {
                    starter.gen_hook.adding_bullet(),
                    starter.gen_hook.aligning("center", "center"),
                }
            })
        end
    },
    {
        "mini.surround",
        event = "BufRead",
        after = function()
            require("mini.surround").setup()
        end
    }
}
