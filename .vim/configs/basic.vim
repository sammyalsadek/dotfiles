" File handling
set noswapfile

" Files searching
set path+=**
set wildignorecase

" Mouse
set mouse=i

" Folding
set nofoldenable

" Window splitting
set splitbelow
set splitright

" Scrolling
set scrolloff=20

" Spell checking
set spell
set spelllang=en_us,en_gb
set spelloptions+=camel

" Styling
colorscheme retrobox
set background=dark
set number
set relativenumber
set cursorline
set colorcolumn=80
set signcolumn=yes
autocmd BufEnter * :syntax sync fromstart
