" Script-local state
let s:file_cache = []
let s:cache_loading = 0
let s:pending_open = 0
let s:search_query = ''
let s:filtered_files = []
let s:buf_nr = -1

" Build find command with excluded directories
function! s:BuildFindCommand()
    let l:exclude_args = join(map(copy(g:exclude_dirs), '"-not -path \"*/" . v:val . "/*\""'), ' ')
    return ['sh', '-c', 'find . -type f ' . l:exclude_args]
endfunction

" Async file cache refresh
function! s:RefreshFileCache()
    if s:cache_loading | return | endif
    let s:cache_loading = 1
    let s:file_cache = []
    call job_start(s:BuildFindCommand(), #{
        \ out_cb: {ch, msg -> add(s:file_cache, msg)},
        \ close_cb: 's:FileCacheDone',
        \ })
endfunction

function! s:FileCacheDone(channel)
    let s:cache_loading = 0
    if s:pending_open
        let s:pending_open = 0
        call FindFiles()
    endif
endfunction

" Open file search window
function! FindFiles()
    if s:cache_loading
        echon "Loading files..."
        let s:pending_open = 1
        return
    endif

    if empty(s:file_cache)
        echo "No files found"
        return
    endif

    echo ""
    let s:search_query = ''
    let s:filtered_files = copy(s:file_cache)
    let s:buf_nr = bufnr('__FileSearch__', 1)

    execute 'silent! botright 15split __FileSearch__'

    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal nowrap
    setlocal nonumber
    setlocal norelativenumber
    setlocal cursorline
    setlocal nomodifiable
    setlocal nospell

    mapclear <buffer>
    imapclear <buffer>

    call s:UpdateDisplay()
    call s:StartInput()
endfunction

" Close search window
function! s:CloseSearch()
    if bufexists(s:buf_nr)
        execute 'silent! bdelete! ' . s:buf_nr
    endif
    redraw
    echo ""
endfunction

" Start input loop
function! s:StartInput()
    redraw
    echo "> " . s:search_query

    try
        let l:c = getchar()
        let l:char = type(l:c) == 0 ? nr2char(l:c) : l:c
    catch /^Vim:Interrupt$/
        call s:CloseSearch()
        return
    endtry

    if l:char == "\<CR>"
        call s:SelectFile()
        return
    elseif l:char == "\<C-n>"
        normal! j
    elseif l:char == "\<C-p>"
        normal! k
    elseif l:char == "\<BS>"
        let s:search_query = s:search_query[:-2]
        call s:FilterAndUpdate()
    elseif l:char == "\<C-w>"
        let s:search_query = substitute(s:search_query, '\w\+\s*$', '', '')
        call s:FilterAndUpdate()
    elseif l:char =~ '[[:print:]]'
        let s:search_query .= l:char
        call s:FilterAndUpdate()
    endif

    call s:StartInput()
endfunction

" Filter files and update display
function! s:FilterAndUpdate()
    if s:search_query == ''
        let s:filtered_files = copy(s:file_cache)
    else
        let s:filtered_files = filter(copy(s:file_cache),
            \ 'fnamemodify(v:val, ":t") =~? s:search_query')
    endif
    call s:UpdateDisplay()
endfunction

" Update display with highlighting
function! s:UpdateDisplay()
    setlocal modifiable
    silent! %delete _

    if empty(s:filtered_files)
        call setline(1, 'No files found')
    else
        call setline(1, s:filtered_files[:200])
    endif

    setlocal nomodifiable

    syntax clear
    if !empty(s:search_query)
        let l:escaped = escape(s:search_query, '\.*[]^$')
        execute 'syntax match FileSearchMatch /\c' . l:escaped . '/'
        highlight FileSearchMatch ctermfg=Yellow guifg=#ffff00 cterm=bold gui=bold
    endif

    call cursor(1, 1)
endfunction

" Select file under cursor
function! s:SelectFile()
    let l:line_num = line('.')
    if l:line_num > 0 && l:line_num <= len(s:filtered_files)
        let l:file = s:filtered_files[l:line_num - 1]
        call s:CloseSearch()
        execute 'edit ' . fnameescape(l:file)
    else
        call s:StartInput()
    endif
endfunction

augroup file_cache
    autocmd!
    autocmd VimEnter * call s:RefreshFileCache()
augroup END
