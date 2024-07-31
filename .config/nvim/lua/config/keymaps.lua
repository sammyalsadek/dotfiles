-- Moving around buffers
vim.keymap.set("n", "<c-n>", ":bn<cr>")
vim.keymap.set("n", "<c-p>", ":bp<cr>")

-- Only using control rather than ESC key
vim.keymap.set("i", "<c-c>", "<Esc>")

-- Global text search
vim.keymap.set("n", "<c-g>", ":grep! ")

-- Destroy
vim.keymap.set("i", "<c-x>", "<nop>")
vim.keymap.set("n", "Q", "<nop>")
