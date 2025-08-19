---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim", "LZN" },
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
}
