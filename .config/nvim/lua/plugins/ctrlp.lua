return {
    {
        'ctrlpvim/ctrlp.vim',
        init = function()
            vim.keymap.set("n", "<c-f>", ":CtrlP :pwd<cr>")
            vim.g.ctrlp_by_filename=1
        end
    },
}
