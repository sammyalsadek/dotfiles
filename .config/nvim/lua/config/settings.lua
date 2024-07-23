-- Styling
vim.cmd.colorscheme("desert")
vim.opt.number=true
vim.opt.cursorline=true
vim.opt.cursorcolumn=true
vim.opt.colorcolumn="80"
vim.opt.scrolloff=20
vim.opt.foldenable=false

-- In file text searching
vim.opt.ignorecase=true
vim.opt.smartcase=true

-- Global file searching
vim.opt.wildignorecase=true
vim.opt.wildignore="*/node_modules/*,*/build/*,*/dist/*,*/env/*"
vim.opt.path:append("**")

-- Global text searching
vim.o.grepprg=[[grep -nR --exclude-dir={node_modules,build,dist,env} --ignore-case $* | redraw! | copen]]
