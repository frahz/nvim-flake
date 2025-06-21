local catppuccin = require("catppuccin");

catppuccin.setup({
    flavour = "mocha",
    no_italic = true;
    integrations = {
        treesitter = true,
        blink_cmp = true,
    },
})

vim.api.nvim_command("colorscheme catppuccin")
