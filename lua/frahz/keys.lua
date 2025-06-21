-- function wrapper for mapping custom keybinds
local map = function(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- leader keymap
vim.g.mapleader = " " -- space

-- center line after jump
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "n", "nzz")

-- keybinds for moving a line up or down
map("n", "<S-Up>", "<cmd>m-2<CR>")
map("n", "<S-Down>", "<cmd>m+<CR>")
map("i", "<S-Up>", "<Esc><cmd>m-2<CR>")
map("i", "<S-Down>", "<Esc><cmd>m+<CR>")
map("v", "<S-Up>", ":m '<-2<CR>gv=gv")
map("v", "<S-Down>", ":m '>+1<CR>gv=gv")

-- paste over something but still keep the same thing in the paste buffer
map("x", "<Leader>p", "\"_dP")

-- disable hlsearch
map("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>")

-- allows paste outside vim
map("n", "<Leader>y", "\"+y")
map("v", "<Leader>y", "\"+y")
map("n", "<Leader>Y", "\"+Y")
