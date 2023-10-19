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
"
" Display the name of the current file
set laststatus=2

" Set tabs to be 4 spaces
set shiftwidth=4 smarttab
set expandtab
set tabstop=8 softtabstop=0

" Fixing backspace issue to delete character placed before insert mode
set backspace=indent,eol,start

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
command! MakeTags !ctags -R .

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocompelete					      			"
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
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
call plug#end()

let g:airline_theme='gruvbox'
colorscheme gruvbox
