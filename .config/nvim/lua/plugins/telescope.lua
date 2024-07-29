return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        local keymap = function(keys, func)
            vim.keymap.set("n", keys, func, {})
        end

        require("telescope").setup({})
        local builtin = require("telescope.builtin")

        keymap("<c-f>", builtin.find_files)
        keymap("<c-g>", builtin.live_grep)
    end
}
