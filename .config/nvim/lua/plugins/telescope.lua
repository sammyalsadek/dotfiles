return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = {
                    "node%_modules/.*",
                    "build/.*",
                    "dist/.*",
                    "env/.*",
                },
                vimgrep_arguments = {
                    'rg',
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    '--no-ignore'
                }
            },
        })

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<c-f>", function()
            builtin.find_files({ no_ignore_parent = true })
        end)
        vim.keymap.set("n", "<c-g>", function()
            builtin.live_grep()
        end)
    end
}
