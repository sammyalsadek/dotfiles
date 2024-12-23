"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if not found
if empty(glob($HOME . "/.vim/autoload/plug.vim"))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), "!isdirectory(v:val.dir)"))
            \ | PlugInstall --sync | source $MYVIMRC
            \ | endif

call plug#begin($HOME . "/.vim/bundle")
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'thaerkh/vim-workspace'
call plug#end()

let g:workspace_autocreate=1
let g:workspace_create_new_tabs=0
let g:workspace_session_directory=$HOME . "/.vim/sessions/"
let g:workspace_undodir=$HOME . "/.vim/undodir/"

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

" SSH compatibility
set mouse=i

" In file text searching
set ignorecase
set smartcase
set hlsearch

" Global file searching
set path+=**
set wildignorecase
set wildignore=*/node_modules/*,*/build/*,*/dist/*,*/env/*,*/.bemol/*,*/.git/*

" Global text searching
command! -nargs=+ Grep execute "silent grep! <args>" | redraw! | copen
let &grepprg="grep -nR --exclude-dir={node_modules,build,dist,env,.bemol,.git}
            \ --exclude=tags
            \ --ignore-case $*"

" Autocompletion and jumping with ctags
if eval("@%") == ''
    function! CtagsCallback(channel, exit_status)
        if a:exit_status == 0
            echomsg "Tags file generated successfully!"
        else
            echohl ErrorMsg
            echomsg "Failed to generate tags file"
            echohl None
        endif
    endfunction

    if filereadable('tags')
        au VimEnter * call job_start(['ctags', '-R', '.'], {'exit_cb': 'CtagsCallback'})
    else
        let choice = confirm("No tags file found. Do you want to generate it using ctags?", "&Yes\n&No", 1)
        if choice == 1
            au VimEnter * call job_start(['ctags', '-R', '.'], {'exit_cb': 'CtagsCallback'})
        else
            echomsg "Tags file creation aborted."
        endif
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Re-mappings				                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around buffers
nnoremap <c-n> :bn<cr>
nnoremap <c-p> :bp<cr>

" Global file searching
nnoremap <c-f> :find<space>*

" Global text searching
nnoremap <c-g> :Grep<space>

" Only using control rather than ESC key
inoremap <c-c> <Esc>

" Destroy
nnoremap Q <nop>
