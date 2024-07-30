 local api = vim.api

 api.nvim_command("autocmd TermOpen * startinsert")
 api.nvim_command("autocmd TermOpen * setlocal nonumber")
 api.nvim_command("autocmd TermEnter * setlocal signcolumn=no")

 vim.keymap.set("ca", "term", "split | term")
 vim.keymap.set('t', '<esc>', "<C-\\><C-n>")

