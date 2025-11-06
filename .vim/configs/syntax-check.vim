let g:syntax_errors = {}
let g:syntax_check_running = 0

function! SyntaxCheck()
    " Skip if already running or in insert mode
    if g:syntax_check_running || mode() =~ '^i'
        return
    endif

    " Clear previous signs and errors
    sign unplace *
    let g:syntax_errors = {}
    let g:syntax_check_running = 1
    
    let checkers = {
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
    
    if has_key(checkers, &filetype)
        let g:syntax_check_output = []
        let g:syntax_check_file = expand('%:p')
        call job_start(checkers[&filetype], {
            \ "out_io": "pipe",
            \ "err_io": "pipe",
            \ "err_cb": "SyntaxCheckCallback",
            \ "close_cb": "SyntaxCheckDone"
            \ })
    else
        let g:syntax_check_running = 0
    endif
endfunction

function! SyntaxCheckCallback(channel, msg)
    call add(g:syntax_check_output, a:msg)
endfunction

function! SyntaxCheckDone(channel)
    let g:syntax_check_running = 0

    " Only show errors if we're still in the same file, and if not rerun check
    if g:syntax_check_file != expand('%:p')
        call SyntaxCheck()
        return
    endif
    
    " Parse errors and store them
    for line in g:syntax_check_output
        let parts = split(line, ':')
        if len(parts) >= 3
            let line_num = str2nr(parts[1])
            if line_num > 0
                let g:syntax_errors[line_num] = trim(join(parts[2:], ':'))
                execute 'sign place ' . line_num . ' line=' . line_num . ' name=SyntaxError file=' . expand('%:p')
            endif
        endif
    endfor
    " Force show error for current line
    call ShowErrorMessage()
endfunction

function! ShowErrorMessage()
    let line_num = line('.')
    if has_key(g:syntax_errors, line_num)
        redraw
        echo g:syntax_errors[line_num]
    else
        echo ""
    endif
endfunction

" Define error sign
sign define SyntaxError text=>> texthl=ErrorMsg

autocmd BufEnter * silent! call SyntaxCheck()
autocmd TextChanged * silent! write | call SyntaxCheck()
autocmd InsertLeave * silent! write | call SyntaxCheck()
autocmd CursorMoved,CursorMovedI * call ShowErrorMessage()
