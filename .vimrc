"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings				      			"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tell vim to not try to be vi
set nocompatible

" Enable syntax
syntax enable

" Show relative number column along with the current line number
set number
set relativenumber

" Keep the cursor in the center of the screen
nnoremap j jzz
nnoremap k kzz

" Editor theme
try
    colorscheme retrobox
catch
    colorscheme slate
endtry
set background=dark
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color GNU screen.
  set t_ut=
endif

" Display the name of the current file
set laststatus=2

" Set tabs to be 4 spaces
set shiftwidth=4 smarttab
set expandtab
set tabstop=8 softtabstop=0
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
nnoremap H Hzz
nnoremap M Mzz
nnoremap L Lzz
nnoremap gg ggzz
nnoremap G Gzz
