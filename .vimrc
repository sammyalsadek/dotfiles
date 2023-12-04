"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings				      			"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

" Tell vim to not try to be vi
set nocompatible

" Show the syntax
syntax on

" Show relative number column along with the current line number
set number
set relativenumber

" Hide mode identifier (Plugin installed to replace)
set noshowmode

" Highlights the line where the cursor is
set cursorline

" Adds spell checking
set spell

" Editor theme
set background=dark

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color GNU screen.
  set t_ut=
endif

" Set tabs to be 4 spaces
set shiftwidth=4 smarttab
set expandtab
set tabstop=8 softtabstop=0

" Fixing backspace issue to delete character placed before insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Set UTF-8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

set ai "Auto indent
set si "Smart indent

" Having longer update time (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=50

set undodir=~/.vim/undo-dir
set undofile

set colorcolumn=100

" Keep cursor in the center where remaps to not cover
set scrolloff=100

" Display all matching files when we tab complete
set wildmenu
set wildignore=*.exe,*.dll,*.pdb

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tag jumping					      			"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Create the 'tags' file (may need to install ctags first)
" - Use Ctrl-] to jump to tag under cursor
" - Use g-Ctrl-] for ambiguous tags
" - Use Ctrl-t to jump back up the tag stack
"command! MakeTags !ctags -R .

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/bundle')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
call plug#end()

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> <c-]> <plug>(lsp-definition)
    nmap <buffer> gd <plug>(lsp-declaration)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gh <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:airline_theme='apprentice'
colorscheme habamax
hi Normal guibg=NONE ctermbg=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Re-mappings					                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keep the cursor in the center of the screen
nnoremap j jzz
nnoremap k kzz
nnoremap { {zz
nnoremap } }zz
nnoremap <c-u> <c-u>zz
nnoremap <c-d> <c-d>zz
nnoremap gg ggzz
nnoremap G Gzz
nnoremap n nzzzv
nnoremap N Nzzzv
vnoremap j jzz
vnoremap k kzz
vnoremap { {zz
vnoremap } }zz
vnoremap <c-u> <c-u>zz
vnoremap <c-d> <c-d>zz
vnoremap gg ggzz
vnoremap G Gzz

" Add new line
nnoremap L i<CR><c-c>h

" Only using control rather than ESC key
inoremap <c-c> <Esc>

" Destroy Q action
nnoremap Q <nop>

" Turn off search highlights until the next search
nnoremap <c-n> :noh<CR>
