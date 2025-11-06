" Completion settings
set pumheight=10
set completeopt=menu,menuone,noinsert,noselect

" Auto-trigger completion after 1 character
autocmd InsertCharPre * call AutoComplete()
function! AutoComplete()
    if pumvisible() | return | endif
    let char = v:char
    " Trigger on any word character
    if char =~ '\w'
        call feedkeys("\<C-n>", 'n')
    elseif char =~ '\W' && pumvisible()
        call feedkeys("\<C-e>", 'n')
    endif
endfunction

" Tag generation
augroup ctags_gen
    autocmd!
    autocmd VimEnter * call GenerateCtagsOnEnter()
    autocmd BufWritePost * call GenerateCtagsOnSave()
augroup END

function! GenerateCtagsOnEnter()
    if empty(eval("@%"))
        if filereadable("tags") || confirm("No tags file found. Generate it?", "&Yes\n&No", 1) == 1
            call RunCtagsCommand()
        else
            echomsg "Tags file creation aborted."
        endif
    endif
endfunction

function! GenerateCtagsOnSave()
    if filereadable("tags")
        call RunCtagsCommand()
    endif
endfunction

function! RunCtagsCommand()
    " Remove existing tags file to avoid corruption issues
    if filereadable("tags")
        call delete("tags")
    endif

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
    let s:error_output = ""
endfunction

function! CtagsErrorCallback(channel, msg)
    let s:error_output .= a:msg . "\n"
endfunction

function! CtagsCallback(channel, exit_status)
    if a:exit_status != 0
        echohl ErrorMsg
        echomsg "Failed to generate tags file: " . s:error_output
        echohl None
    endif
endfunction
