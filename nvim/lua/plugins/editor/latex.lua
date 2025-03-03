return {
    "lervag/vimtex",
    lazy = false, -- Load on startup to ensure PDF viewers work
    config = function()
        -- PDF Viewer settings
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_view_general_viewer = "zathura"

        -- Compiler settings
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_compiler_latexmk = {
            build_dir = "",
            callback = 1,
            continuous = 1,
            executable = "latexmk",
            hooks = {},
            options = {
                "-verbose",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
            },
        }

        -- Enable syntax conceal
        vim.g.vimtex_syntax_enabled = 1
        vim.g.vimtex_syntax_conceal_enabled = 1

        -- Enable folding
        vim.g.vimtex_fold_enabled = 1

        -- Disable imaps (if you don't want VimTeX's insert mode mappings)
        -- vim.g.vimtex_imaps_enabled = 0

        -- Disable quickfix auto open
        vim.g.vimtex_quickfix_enabled = 1
        vim.g.vimtex_quickfix_mode = 2
        vim.g.vimtex_quickfix_open_on_warning = 0

        -- TOC settings
        vim.g.vimtex_toc_config = {
            name = "TOC",
            layers = { "content", "todo", "include" },
            resize = 1,
            split_width = 30,
            todo_sorted = 0,
            show_help = 1,
            show_numbers = 1,
        }
    end,
}
