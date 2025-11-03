set path+=**
set wildignorecase
let &wildignore = join(map(copy(g:exclude_dirs), '"*/" . v:val . "/*,*/" . v:val'), ',')
