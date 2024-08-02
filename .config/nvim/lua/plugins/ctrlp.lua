return {
    {
        'ctrlpvim/ctrlp.vim',
        init = function()
            vim.keymap.set("n", "<c-f>", ":CtrlP :pwd<cr>")
        end
    },
}
