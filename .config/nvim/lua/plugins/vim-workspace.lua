return {
    {
        "thaerkh/vim-workspace",
        lazy = false,
        priority = 1000,
        init = function()
            vim.g.workspace_autocreate=1
            vim.g.workspace_create_new_tabs=0
            vim.g.workspace_session_directory=os.getenv( "HOME" ) .. "/.nvim/sessions/"
            vim.g.workspace_undodir=os.getenv("HOME") .. "/.nvim/undodir/"
        end
    }
}
