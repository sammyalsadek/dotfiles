" File handling
set noswapfile

" File searching
set path+=**
set wildignorecase

" File text searching
set ignorecase
set smartcase
set hlsearch

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
autocmd FileType qf setlocal nospell

" Styling
colorscheme retrobox
set background=dark
set number
set relativenumber
set cursorline
set colorcolumn=80
set signcolumn=yes
autocmd BufEnter * :syntax sync fromstart
