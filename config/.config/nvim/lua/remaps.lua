vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves current line down a line" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves current line up a line" })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("x", "<leader>p", '"_dP', {
	desc = "deletes text without affecting the default register contents and then paste it before the cursor position.",
})

-- Yanking remaps
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Remaps pv to open the explore on a vertical split
vim.keymap.set("n", "<leader>pv", ":Vex<CR>")
vim.keymap.set("n", "<leader>b%", ":vsplit<CR>")

-- Sets leader + enter to source the file
vim.keymap.set("n", "<Leader><CR>", ":so ~/.vimrc<CR>")

-- Remaps for navigating quick fixes
vim.keymap.set("n", "<C-j>", ":cnext<CR>")
vim.keymap.set("n", "<C-k>", ":cprev<CR>")
vim.keymap.set("n", "<C-E>", ":copen<CR>")

vim.keymap.set("n", "<leader>zc", "zfap")
