"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if not found
if empty(glob($HOME . '/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \ | PlugInstall --sync | source $MYVIMRC
            \ | endif

call plug#begin($HOME . '/.vim/bundle')
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
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

let g:workspace_autocreate=1
let g:workspace_create_new_tabs=0
let g:workspace_session_directory=$HOME . '/.vim/sessions/'
let g:workspace_undodir=$HOME . '/.vim/undodir/'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings				      			"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Styling
colorscheme retrobox
set background=dark
set number
set cursorline
set colorcolumn=80
set scrolloff=20
set nofoldenable

" In file text searching
set ignorecase
set smartcase
set hlsearch

" Global file searching
set wildignorecase
set wildignore=*/node_modules/*,*/build/*,*/dist/*,*/env/*
set path+=**

" Global text searching
command! -nargs=+ Grep execute 'silent grep! <args>' | redraw! | copen
cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() =~# '^grep')
            \ ? 'Grep' : 'grep'
let &grepprg='grep -nR --exclude-dir={node_modules,build,dist,env}
            \ --ignore-case $*'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Re-mappings				                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around buffers
nnoremap <c-n> :bn<cr>
nnoremap <c-p> :bp<cr>

" Only using control rather than ESC key
inoremap <c-c> <Esc>

" Destroy
inoremap <c-x> <nop>
nnoremap Q <nop>
