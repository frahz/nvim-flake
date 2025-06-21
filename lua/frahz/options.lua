-- [[ options.lua ]]
local opt = vim.opt

-- [[ context ]]
opt.nu = true
opt.relativenumber = true
opt.scrolloff = 8

-- [[ whitespace ]]
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- [[ search ]]
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- [[ misc ]]
opt.swapfile = false

-- [[ indent ]]
opt.list = true
opt.listchars = {
    lead = "⋅",
    tab = "│ ",
    trail = "•",
}

vim.g.clipboard = {
    name = "osc52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*")
    },
    paste = {
        ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        ["*"] = require("vim.ui.clipboard.osc52").paste("*")
    },
}

-- [[ netrw ]]
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = ""
vim.g.netrw_list_hide = vim.g.netrw_list_hide .. "^\\./" -- hide . directory
vim.g.netrw_list_hide = vim.g.netrw_list_hide .. ","
