return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
        },
        -- optional `vim.uv` typings for lazydev
        { "Bilal2453/luvit-meta", lazy = true },
        "mfussenegger/nvim-jdtls",
        {
            url = "awsammy@git.amazon.com:pkg/NinjaHooks",
            branch = "mainline",
            lazy = false,
            config = function(plugin)
                vim.opt.rtp:prepend(plugin.dir .. "/configuration/vim/amazon/brazil-config")
            end,
        },
        "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
        local lspconfig = require("lspconfig")
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")
        local configs = require("lspconfig.configs")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        vim.filetype.add({
            filename = {
                ['Config'] = function()
                    vim.b.brazil_package_Config = 1
                    return 'brazil-config'
                end,
            },
        })
        configs.barium = {
            default_config = {
                cmd = {'barium'};
                filetypes = {'brazil-config'};
                root_dir = function(fname)
                    return lspconfig.util.find_git_ancestor(fname)
                end;
                settings = {};
            };
        }
        lspconfig.barium.setup({})

        local default_capabilities = vim.lsp.protocol.make_client_capabilities()
        default_capabilities = vim.tbl_deep_extend(
            "force",
            default_capabilities,
            cmp_nvim_lsp.default_capabilities()
        )

        local server_configs = {
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        diagnostics = {
                            disable = {
                                "missing-fields"
                            }
                        },
                    },
                    tsserver = {},
                },
            },
        }

        mason.setup()

        local mason_ensure_installed = vim.tbl_keys(server_configs or {})
        vim.list_extend(
            mason_ensure_installed,
            {
                "stylua",
                "jdtls",
            }
        )
        mason_tool_installer.setup({
            ensure_installed = mason_ensure_installed
        })

        mason_lspconfig.setup({
            handlers = {
                function(server_name)
                    local server_config = server_configs[server_name] or {}
                    server_config.capabilities = vim.tbl_deep_extend(
                        "force",
                        default_capabilities,
                        server_config.capabilities or {}
                    )
                    lspconfig[server_name].setup(server_config)
                end,
                ['jdtls'] = function() end,
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach-keybinds", { clear = true }),
            callback = function(e)
                local keymap = function(keys, func)
                    vim.keymap.set("n", keys, func, { buffer = e.buf })
                end

                keymap("<c-]", vim.lsp.buf.definition)
                keymap("gd", vim.lsp.buf.declaration)
                keymap("gr", vim.lsp.buf.references)
                keymap("gi", vim.lsp.buf.implementation)
                keymap("gt", vim.lsp.buf.type_definition)
                keymap("gl", vim.lsp.buf.code_action)
                keymap("gh", vim.lsp.buf.hover)
            end
        })
    end
}
