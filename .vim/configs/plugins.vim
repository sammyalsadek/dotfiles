let data_dir = $HOME . "/.vim/autoload/plug.vim"
if empty(glob(data_dir))
    silent execute "!curl -fLo " . data_dir . " --create-dirs "
                \ . "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

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
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

let g:workspace_autocreate=1
let g:workspace_create_new_tabs=0
let g:workspace_session_directory=$HOME . "/.vim/sessions/"
let g:workspace_undodir=$HOME . "/.vim/undodir/"
