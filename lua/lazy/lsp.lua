return {
    {
        "fidget.nvim",
        event = "DeferredUIEnter",
        after = function()
            require("fidget").setup({})
        end
    },
    {
        "nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        before = function()
            LZN.trigger_load("blink.cmp")
        end,
        after = function()
            -- Enable lspconfig
            local lspconfig = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.diagnostic.config({
                virtual_text = false,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "●",
                        [vim.diagnostic.severity.WARN] = "●",
                        [vim.diagnostic.severity.INFO] = "●",
                        [vim.diagnostic.severity.HINT] = "●",
                    },
                },
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    border = "single",
                    source = true,
                    header = "",
                    prefix = "",
                },
            })

            local servers = {
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            imports = {
                                granularity = {
                                    group = "module",
                                },
                            },
                            cargo = {
                                buildScripts = {
                                    enable = true,
                                },
                            },
                            files = {
                                excludeDirs = { ".direnv" },
                            },
                            procMacro = {
                                enable = true
                            },
                        },
                    },
                },
                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--pch-storage=memory",
                        "--clang-tidy",
                        "--suggest-missing-includes",
                        "--all-scopes-completion",
                    },
                    filetypes = { "c", "cpp", "cc" },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                            },
                            diagnostics = {
                                globals = { "vim" },
                                disable = { "missing-fields" },
                            },
                            workspace = {
                                library = {},
                                checkThirdParty = false,
                            },
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                },
                nil_ls = {
                    auto_start = true,
                    settings = {
                        ['nil'] = {
                            formatting = {
                                command = { "nixfmt" },
                            },
                            nix = {
                                maxMemoryMB = 8196,
                                flake = {
                                    autoArchive = false,
                                    autoEvalInputs = false,
                                    nixpkgsInputName = nil,
                                },
                            }
                        }
                    }
                },
                bashls = {},
                pyright = {},
                ts_ls = {},
                gopls = {},
                jsonls = {},
                html = {
                    filetypes = { "django-html", "htmldjango", "html", "templ" }
                },
                -- htmx = {},
                cssls = {},
                tailwindcss = {},
                eslint = {},
                svelte = {},
                marksman = {},
                tinymist = {
                    settings = {
                        formatterMode = "typstyle",
                    },
                },
            }
            for name, server in pairs(servers) do
                server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                lspconfig[name].setup(server)
            end
        end,
        keys = {
            { "gD",         vim.lsp.buf.declaration,             desc = "Go to declaration" },
            { "gd",         vim.lsp.buf.definition,              desc = "Go to definition" },
            { "K",          vim.lsp.buf.hover,                   desc = "Hover documentation" },
            { "gi",         vim.lsp.buf.implementation,          desc = "Go to implementation" },
            { "<C-k>",      vim.lsp.buf.signature_help,          desc = "Signature help" },
            { "<leader>wa", vim.lsp.buf.add_workspace_folder,    desc = "Add workspace folder" },
            { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace folder" },
            {
                "<leader>wl",
                function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end,
                desc = "List workspace folders"
            },
            { "<leader>D",  vim.lsp.buf.type_definition,                        desc = "Type definition" },
            { "<leader>rn", vim.lsp.buf.rename,                                 desc = "Rename symbol" },
            { "<leader>ca", vim.lsp.buf.code_action,                            desc = "Code action" },
            { "<leader>e",  vim.diagnostic.open_float,                          desc = "Open diagnostic float" },
            { "gr",         vim.lsp.buf.references,                             desc = "Go to references" },
            { "<leader>f",  function() vim.lsp.buf.format { async = true } end, desc = "Format buffer" },
        },
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
