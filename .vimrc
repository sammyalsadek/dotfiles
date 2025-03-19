"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if not found
let data_dir = $HOME . "/.vim/autoload/plug.vim"
if empty(glob(data_dir))
    silent execute "!curl -fLo " . data_dir . " --create-dirs "
                \ . "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

" Run PlugInstall if there are missing plugins
let g:plug_dir = $HOME . "/.vim/bundle"
augroup plug_install
    autocmd!
    autocmd VimEnter * if len(filter(values(g:plugs), "!isdirectory(v:val.dir)"))
                \| PlugInstall --sync | source $MYVIMRC
                \| endif
augroup END

call plug#begin(g:plug_dir)
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
" Global variables
let g:exclude_dirs = ["node_modules", "build", "dist", "env", ".bemol", ".git"]

" Styling
colorscheme retrobox
set background=dark
set number
set relativenumber
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
command! -nargs=+ Grep call AsyncGrep(<q-args>)

function! AsyncGrep(query)
    cclose
    call setqflist([])
    let cmd = ["grep", "-nR", "--ignore-case", "--exclude=tags"]
    for dir in g:exclude_dirs
        call extend(cmd, ["--exclude-dir=" . dir])
    endfor
    call extend(cmd, [a:query])
    call job_start(cmd, {
                \ "out_io": "pipe",
                \ "err_io": "pipe",
                \ "out_cb": "AsyncGrepCallback",
                \ "close_cb": "AsyncGrepDone"
                \ })
    echomsg "Searching..."

    function! AsyncGrepCallback(channel, msg)
        caddexpr a:msg
    endfunction

    function! AsyncGrepDone(channel)
        echomsg "Search complete!"
        copen
    endfunction
endfunction

" Autocompletion and jumping with ctags
augroup ctags_gen
    autocmd!
    autocmd VimEnter * call GenerateCtags()
augroup END

function! GenerateCtags()
    if empty(eval("@%"))
        if filereadable("tags") || confirm("No tags file found. Generate it?", "&Yes\n&No", 1) == 1
            let cmd = ["ctags", "-R"]
            for dir in g:exclude_dirs
                call extend(cmd, ["--exclude=" . dir])
            endfor
            call extend(cmd, ["."])
            call job_start(cmd, {
                        \ "out_io": "pipe",
                        \ "err_io": "pipe",
                        \ "exit_cb": "CtagsCallback",
                        \ "err_cb": "CtagsErrorCallback",
                        \})
        else
            echomsg "Tags file creation aborted."
        endif
    endif

    let s:error_output = ""

    function! CtagsErrorCallback(channel, msg)
        let s:error_output .= a:msg . "\n"
    endfunction

    function! CtagsCallback(channel, exit_status)
        if a:exit_status == 0
            echomsg "Tags file generated successfully!"
        else
            echohl ErrorMsg
            echomsg "Failed to generate tags file: " . s:error_output
            echohl None
        endif
    endfunction
endfunction

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
