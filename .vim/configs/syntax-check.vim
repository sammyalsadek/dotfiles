let s:syntax_errors = {}
let s:syntax_check_running = 0

function! s:SyntaxCheck()
    " Skip if already running or in insert mode
    if s:syntax_check_running || mode() =~ '^i'
        return
    endif

    " Clear previous signs and errors
    sign unplace *
    let s:syntax_errors = {}
    let s:syntax_check_running = 1

    let l:checkers = {
        \ 'vim': ['vim', '-e', '-s', '-c', 'source ' . expand('%') . ' | qall!'],
        \ 'sh': ['bash', '-n', expand('%')],
        \ 'zsh': ['zsh', '-n', expand('%')],
        \ 'c': ['gcc', '-fsyntax-only', expand('%')],
        \ 'cpp': ['g++', '-fsyntax-only', expand('%')],
        \ 'java': ['javac', '-Xlint', expand('%')],
        \ 'javascript': ['node', '-c', expand('%')],
        \ 'typescript': ['tsc', '--noEmit', expand('%')],
        \ 'python': ['python', '-m', 'py_compile', expand('%')]
        \ }

    if has_key(l:checkers, &filetype)
        let s:syntax_check_output = []
        let s:syntax_check_file = expand('%:p')
        call job_start(l:checkers[&filetype], {
            \ "out_io": "pipe",
            \ "err_io": "pipe",
            \ "err_cb": "s:SyntaxCheckCallback",
            \ "close_cb": "s:SyntaxCheckDone"
            \ })
    else
        let s:syntax_check_running = 0
    endif
endfunction

function! s:SyntaxCheckCallback(channel, msg)
    call add(s:syntax_check_output, a:msg)
endfunction

function! s:SyntaxCheckDone(channel)
    let s:syntax_check_running = 0

    " Only show errors if we're still in the same file, and if not rerun check
    if s:syntax_check_file != expand('%:p')
        call s:SyntaxCheck()
        return
    endif

    " Parse errors and store them
    for l:line in s:syntax_check_output
        let l:parts = split(l:line, ':')
        if len(l:parts) >= 3
            let l:line_num = str2nr(l:parts[1])
            if l:line_num > 0
                let s:syntax_errors[l:line_num] = trim(join(l:parts[2:], ':'))
                execute 'sign place ' . l:line_num . ' line=' . l:line_num . ' name=SyntaxError file=' . expand('%:p')
            endif
        endif
    endfor
    " Force show error for current line
    call s:ShowErrorMessage()
endfunction

function! s:ShowErrorMessage()
    let l:line_num = line('.')
    if has_key(s:syntax_errors, l:line_num)
        redraw
        echo s:syntax_errors[l:line_num]
    else
        echo ""
    endif
endfunction

" Define error sign
sign define SyntaxError text=>> texthl=ErrorMsg

autocmd BufEnter * silent! call s:SyntaxCheck()
autocmd TextChanged * silent! write | call s:SyntaxCheck()
autocmd InsertLeave * silent! write | call s:SyntaxCheck()
autocmd CursorMoved,CursorMovedI * call s:ShowErrorMessage()
