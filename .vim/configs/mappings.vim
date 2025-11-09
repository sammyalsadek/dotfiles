" Moving around buffers
nnoremap <c-n> :bn<cr>
nnoremap <c-p> :bp<cr>

" Open explorer
nnoremap <c-e> :E<cr>

" Global file searching
nnoremap <c-f> :call FindFiles()<cr>

" Global text searching
nnoremap <c-g> :Grep<space>

" Only using control rather than ESC key
inoremap <c-c> <Esc>

" Destroy
nnoremap Q <nop>
