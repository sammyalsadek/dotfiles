" File text search
set ignorecase
set smartcase
set hlsearch

" Global text search
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
