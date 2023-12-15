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
set colorcolumn=80
set scrolloff=20
set laststatus=2

" Set tabs to be 4 spaces
set tabstop=4 softtabstop=0
set shiftwidth=4 smarttab
set expandtab
set autoindent
set smartindent

" Fixing backspace issue to delete character placed before insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" Show matching brackets when text indicator is over them
set showmatch
set mat=2

" Having longer update time (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=50

" In file text searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" Searching for files and text
set wildmenu
set wildignorecase
set wildignore=*/node_modules/*,*/build/*,*/dist/*
set path+=**
command! -nargs=+ Grep execute 'silent grep! <args>' | redraw! | copen
cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() =~# '^grep') ?
            \ 'Grep' : 'grep'
let &grepprg='grep -n -R --ignore-case
            \ --exclude-dir={node_modules,build,dist} $*'

" Enable persistent undo's
if has('persistent_undo')
    let target_path = expand('~/.vim/undo/')
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif
    let &undodir = target_path
    set undofile
endif

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Create vim sessions
fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
    if filereadable(getcwd() . '/.session.vim')
        execute 'so ' . getcwd() . '/.session.vim'
    endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()

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
            \ | PlugInstall --sync | source $MYVIMRC
            \ | endif

call plug#begin('~/.vim/bundle')
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
    let g:lsp_diagnostics_virtual_text_enabled=0
    let g:lsp_diagnostics_float_cursor=1
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Re-mappings				                	                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only using control rather than ESC key
inoremap <c-c> <Esc>

" Destroy Q action
nnoremap Q <nop>
