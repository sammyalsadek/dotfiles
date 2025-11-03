" Tag generation
augroup ctags_gen
    autocmd!
    autocmd VimEnter * call GenerateCtags()
    autocmd BufWritePost * call UpdateCtags()
augroup END

function! BuildCtagsCmd()
    let cmd = ["ctags", "-R"]
    for dir in g:exclude_dirs
        call extend(cmd, ["--exclude=" . dir])
    endfor
    call extend(cmd, ["."])
    return cmd
endfunction

let s:error_output = ""

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

function! UpdateCtags()
    if filereadable("tags")
        call job_start(BuildCtagsCmd(), {
                    \ "out_io": "pipe",
                    \ "err_io": "pipe",
                    \ "exit_cb": "CtagsCallback",
                    \ "err_cb": "CtagsErrorCallback",
                    \})
    endif
endfunction

function! GenerateCtags()
    if empty(eval("@%"))
        if filereadable("tags") || confirm("No tags file found. Generate it?", "&Yes\n&No", 1) == 1
            call job_start(BuildCtagsCmd(), {
                        \ "out_io": "pipe",
                        \ "err_io": "pipe",
                        \ "exit_cb": "CtagsCallback",
                        \ "err_cb": "CtagsErrorCallback",
                        \})
        else
            echomsg "Tags file creation aborted."
        endif
    endif
endfunction
