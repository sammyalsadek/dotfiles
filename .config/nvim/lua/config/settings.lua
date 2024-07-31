-- Styling
vim.opt.number=true
vim.opt.cursorline=true
vim.opt.colorcolumn="80"
vim.opt.scrolloff=20
vim.opt.foldenable=false
vim.opt.signcolumn="yes"
vim.opt.showmode=false

-- In file text searching
vim.opt.ignorecase=true
vim.opt.smartcase=true

-- Netrw styling
vim.g.netrw_liststyle=3

-- SSH compatibility
vim.opt.mouse="i"

-- Global text searching
vim.o.grepprg=[[grep -nR --exclude-dir={node_modules,build,dist,env} --ignore-case $* | redraw | copen]]
