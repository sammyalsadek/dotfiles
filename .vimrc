"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings				      			"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tell vim to not try to be vi
set nocompatible

" Show relative number column along with the current line number
set number
set relativenumber

" Hide mode identifier (Pluggin installed to replace)
set noshowmode

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

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=50

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

set undodir=~/.vim/undo-dir
set undofile

set colorcolumn=100

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Finding files					      			"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search down into subfolders
" Provides tab-completion for all file-related tasks
" - set path+=**

" Display all matching files when we tab complete
set wildmenu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tag jumping					      			"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Create the 'tags' file (may need to install ctags first)i
" - Use Ctrl-] to jump to tag under cursor
" - Use g-Ctrl-] for ambiguous tags
" - Use Ctrl-t to jump back up the tag stack
"command! MakeTags !ctags -R .

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete					      			"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The good stuff is documented in |ins-completion|
"
" Highlights
" - Ctrl-x Ctrl-n for JUST this file
" - Ctrl-x Ctrl-f for filenames (works with our path trick)
" - Ctrl-x Ctrl-] for tags only
" - Ctrl-n for anything specific by the 'complete' option
"
" Now we can
" - Use Ctrl-n and Ctrl-p to go back and forth in the suggestion list

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
call plug#end()

let g:airline_theme='apprentice'
colorscheme habamax
hi Normal guibg=NONE ctermbg=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Remappings					                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keep the cursor in the center of the screen
nnoremap j jzz
nnoremap k kzz
nnoremap { {zz
nnoremap } }zz
nnoremap <c-u> <c-u>zz
nnoremap <c-d> <c-d>zz
nnoremap H Hzz
nnoremap M Mzz
nnoremap L Lzz
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
vnoremap H Hzz
vnoremap M Mzz
vnoremap L Lzz
vnoremap gg ggzz
vnoremap G Gzz

" Only using control rather than ESC key
inoremap <c-c> <Esc>

" Destroy Q action
nnoremap Q <nop>

" Turn off search highlights until the next search
nnoremap <c-n> :noh<CR>
