" Global text search command
command! -nargs=+ Grep call s:AsyncGrep(<q-args>)

function! s:AsyncGrep(query)
    cclose
    call setqflist([])

    let l:cmd = ["grep", "-nR", "--ignore-case", "--exclude=tags"]
    for l:dir in g:exclude_dirs
        call extend(l:cmd, ["--exclude-dir=" . l:dir])
    endfor
    call extend(l:cmd, [a:query])

    call job_start(l:cmd, #{
        \ out_io: "pipe",
        \ err_io: "pipe",
        \ out_cb: "s:AsyncGrepCallback",
        \ close_cb: "s:AsyncGrepDone"
        \ })
    echomsg "Searching..."
endfunction

function! s:AsyncGrepCallback(channel, msg)
    caddexpr a:msg
endfunction

function! s:AsyncGrepDone(channel)
    copen
endfunction
