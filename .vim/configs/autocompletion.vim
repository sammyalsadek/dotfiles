" Completion settings
set pumheight=10
set completeopt=menu,menuone,noinsert,noselect

" Script-local state
let s:ctags_generating = 0
let s:ctags_show_success = 0
let s:error_output = ""

" Auto-trigger completion after 1 character
function! s:AutoComplete()
    if pumvisible() | return | endif
    let l:char = v:char
    if l:char =~ '\w'
        call feedkeys("\<C-n>", 'n')
    elseif l:char =~ '\W' && pumvisible()
        call feedkeys("\<C-e>", 'n')
    endif
endfunction

autocmd InsertCharPre * call s:AutoComplete()

" Generate ctags on vim enter
function! s:GenerateCtagsOnEnter()
    if empty(eval("@%"))
        if filereadable("tags") || confirm("No tags file found. Generate it?", "&Yes\n&No", 1) == 1
            let s:ctags_show_success = 1
            call s:RunCtagsCommand()
        else
            echomsg "Tags file creation aborted."
        endif
    endif
endfunction

" Generate ctags on file save
function! s:GenerateCtagsOnSave()
    if filereadable("tags")
        let s:ctags_show_success = 0
        call s:RunCtagsCommand()
    endif
endfunction

" Run ctags command
function! s:RunCtagsCommand()
    let s:ctags_generating = 1
    let l:cmd = ["ctags", "-R"]
    for l:dir in g:exclude_dirs
        call extend(l:cmd, ["--exclude=" . l:dir])
    endfor
    call extend(l:cmd, ["."])
    call job_start(l:cmd, #{
        \ out_io: "pipe",
        \ err_io: "pipe",
        \ exit_cb: "s:CtagsCallback",
        \ err_cb: "s:CtagsErrorCallback",
        \ })
    let s:error_output = ""
endfunction

function! s:CtagsErrorCallback(channel, msg)
    let s:error_output .= a:msg . "\n"
endfunction

function! s:CtagsCallback(channel, exit_status)
    let s:ctags_generating = 0
    if a:exit_status == 0 && s:ctags_show_success
        echomsg "Tags file generated successfully!"
    elseif a:exit_status != 0
        echohl ErrorMsg
        echomsg "Failed to generate tags file: " . s:error_output
        echohl None
    endif
endfunction

augroup ctags_gen
    autocmd!
    autocmd VimEnter * call s:GenerateCtagsOnEnter()
    autocmd BufWritePost * call s:GenerateCtagsOnSave()
augroup END
