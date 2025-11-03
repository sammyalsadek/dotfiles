" Tag generation
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
