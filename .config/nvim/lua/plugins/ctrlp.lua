return {
    {
        'kien/ctrlp.vim',
        init = function()
            vim.keymap.set("n", "<c-f>", ":CtrlP<cr>")
        end
    },
}
