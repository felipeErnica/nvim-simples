return {
    'mfussenegger/nvim-jdtls',
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    ft = "java",
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

        capabilities.workspace = {
            configuration = true,
            didChangeWatchedFiles = {
                dynamicRegistration = true
            },
            didChangeConfiguration = {
                dynamicRegistration = true
            }
        }

        local on_attach = function(client, bufnr)
            -- Aqui define <Ctrl-x> + <Ctrl-o> para ativar o autocomplete, mas ele irá se ativar quando você digita também
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', "v:lua.vim.lsp.omnifunc")
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup('Format', { clear = true }),
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format()
                end
            })
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        end


        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        local workspace_dir = '~/dev/workspace/' .. project_name

        local config = {
            cmd = {
                'java',
                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-Dlog.protocol=true',
                '-Dlog.level=ALL',
                '-Xmx1g',
                '--add-modules=ALL-SYSTEM',
                '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

                '-jar', '~/dev/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
                -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
                -- Must point to the                                                     Change this to
                -- eclipse.jdt.ls installation                                           the actual version

                '-configuration', '~/dev/jdtls/config_linux/arm',
                -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                -- Must point to the                      Change to one of `linux`, `win` or `mac`
                -- eclipse.jdt.ls installation            Depending on your system.


                -- See `data directory configuration` section in the README
                '-data', workspace_dir,
            },


            root_dir = require("jdtls.setup").find_root({ 'gradlew', '.git', 'mvnw' }),
            on_attach = on_attach,
            capabilities = capabilities,

            settings = {
                java = {
                    signatureHelp = { enabled = true },
                    contentProvider = { preferred = 'fernflower' },
                    completion = {
                        favoriteStaticMembers = {
                            "org.hamcrest.MatcherAssert.assertThat",
                            "org.hamcrest.Matchers.*",
                            "org.hamcrest.CoreMatchers.*",
                            "org.junit.jupiter.api.Assertions.*",
                            "java.util.Objects.requireNonNull",
                            "java.util.Objects.requireNonNullElse",
                            "org.mockito.Mockito.*"
                        },
                        filteredTypes = {
                            "com.sun.*",
                            "io.micrometer.shaded.*",
                            "java.awt.*",
                            "jdk.*",
                            "sun.*",
                        },
                    },
                    sources = {
                        organizeImports = {
                            starThreshold = 9999,
                            staticStarThreshold = 9999,
                        },
                    },
                    codeGeneration = {
                        toString = {
                            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                        },
                        hashCodeEquals = {
                            useJava7Objects = true,
                        },
                        useBlocks = true,
                    },
                    configuration = {
                        runtimes = {
                            {
                                name = "OpenJDK Runtime Environment (build 21.0.4+7-Ubuntu-1ubuntu224.04)",
                                path = "/usr/lib/jvm/java-21-openjdk-amd64",
                                default = true
                            }
                        }
                    }
                }
            },
        }

        require('jdtls').start_or_attach(config)
    end
}
