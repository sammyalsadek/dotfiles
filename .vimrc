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
Plug 'ctrlpvim/ctrlp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
call plug#end()

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nnoremap <buffer> <c-]> <plug>(lsp-definition)
    nnoremap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> gr <plug>(lsp-references)
    nnoremap <buffer> gl <plug>(lsp-document-diagnostics)
    nnoremap <buffer> gd <plug>(lsp-declaration)
    nnoremap <buffer> gi <plug>(lsp-implementation)
    nnoremap <buffer> gt <plug>(lsp-type-definition)
    nnoremap <buffer> <expr><c-k> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-j> lsp#scroll(-4)
    let g:lsp_diagnostics_virtual_text_enabled=0
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:workspace_autocreate=1
let g:workspace_create_new_tabs=0
let g:workspace_session_directory=$HOME . '/.vim/sessions/'
let g:workspace_undodir=$HOME . '/.vim/undodir/'
let g:ctrlp_map='<c-f>'
let g:ctrlp_cmd='CtrlP :pwd'
let g:ctrlp_by_filename=1

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

" Netrw styling
let g:netrw_liststyle=3

" In file text searching
set ignorecase
set smartcase
set hlsearch

" Global file searching
set wildignorecase
set wildignore=*/node_modules/*,*/build/*,*/dist/*,*/env/*

" SSH compatibility
set mouse=i

" Global text searching
command! -nargs=+ Grep execute 'silent grep! <args>' | redraw! | copen
let &grepprg='grep -nR --exclude-dir={node_modules,build,dist,env}
            \ --ignore-case $*'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Re-mappings				                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around buffers
nnoremap <c-n> :bn<cr>
nnoremap <c-p> :bp<cr>

" Global text searching
nnoremap <c-g> :Grep<space>

" Only using control rather than ESC key
inoremap <c-c> <Esc>

" Destroy
inoremap <c-x> <nop>
nnoremap Q <nop>
