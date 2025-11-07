set path+=**
set wildignorecase
set maxmempattern=100000
let g:ctrlp_cmd = "CtrlP"
let g:ctrlp_custom_ignore = &wildignore
let g:ctrlp_working_path_mode = ''
let g:ctrlp_by_filename = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME . '/.vim/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:15'
