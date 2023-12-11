"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings				      			                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
set nocompatible
set encoding=utf8
set ffs=unix,dos,mac

" Styling
syntax on
if &term =~ '256color'
  set t_ut=
endif
colorscheme retrobox
set background=dark
set number
set cursorline
set colorcolumn=100
set scrolloff=20

" Adds spell checking
" set spell

" Set tabs to be 4 spaces
set tabstop=4 softtabstop=0
set shiftwidth=4 smarttab
set expandtab
set ai "Auto indent
set si "Smart indent

" Fixing backspace issue to delete character placed before insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" In file text searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" Show matching brackets when text indicator is over them
set showmatch
set mat=2 " How many tenths of a second to blink when matching brackets

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Having longer update time (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=50

set undodir=~/.vim/undo-dir
set undofile

" Display all matching files when we tab complete
set wildmenu
set wildignore=*.exe,*.dll,*.pdb

" Searching
set path+=**
set gp=git\ grep\ -n

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tag jumping	                        				      			"
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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
call plug#end()

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nnoremap <buffer> <c-]> <plug>(lsp-definition)
    nnoremap <buffer> gd <plug>(lsp-declaration)
    nnoremap <buffer> gr <plug>(lsp-references)
    nnoremap <buffer> gh <plug>(lsp-hover)
    nnoremap <buffer> gi <plug>(lsp-implementation)
    nnoremap <buffer> gt <plug>(lsp-type-definition)
    nnoremap <buffer> gl <plug>(lsp-document-diagnostics)
    nnoremap <buffer> [g <plug>(lsp-previous-diagnostic)
    nnoremap <buffer> ]g <plug>(lsp-next-diagnostic)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_virtual_text_enabled=0
let g:lsp_diagnostics_float_cursor=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Re-mappings				                	                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add new line
nnoremap L i<CR><c-c>h

" Only using control rather than ESC key
inoremap <c-c> <Esc>

" Destroy Q action
nnoremap Q <nop>

" Turn off search highlights until the next search
nnoremap <c-n> :noh<CR>
