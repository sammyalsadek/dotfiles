let g:exclude_dirs = [
            \"node_modules", "build", "dist", "env", "venv", ".venv", ".bemol",
            \ ".git", "tmp", "temp", "logs", "coverage", ".brazil",
            \".builder-mcp", "figma_images", ".cache", "out", "target",
            \"release-info"
            \]

let &wildignore = join(map(copy(g:exclude_dirs), '"*/" . v:val . "/*,*/" . v:val'), ',')
