return {
    -- Git signs in the gutter
    {
        "lewis6991/gitsigns.nvim",
        event = "LazyFile",
        keys = {
            {
                "<leader>gb",
                function()
                    require("gitsigns").blame_line()
                end,
                desc = "Git Blame Line",
            },
            {
                "<leader>gY",
                function()
                    require("gitsigns").copy_url_to_clipboard()
                end,
                desc = "Git Browse (copy)",
                mode = { "n", "x" },
            },
            {
                "<leader>gB",
                function()
                    require("gitsigns").open_in_browser()
                end,
                desc = "Git Browse (open)",
                mode = { "n", "x" },
            },
            {
                "<leader>gl",
                function()
                    require("gitsigns").show_file_history()
                end,
                desc = "Git Log",
            },
            {
                "<leader>gL",
                function()
                    require("gitsigns").show_project_history()
                end,
                desc = "Git Log (cwd)",
            },
            {
                "<leader>gf",
                function()
                    require("gitsigns").file_history()
                end,
                desc = "Git Current File History",
            },
            {
                "<leader>gg",
                function()
                    vim.cmd(
                        "lua require('lazyvim.util').terminal.open('lazygit', { cwd = require('lazyvim.util').root.get() })"
                    )
                end,
                desc = "Lazygit (Root Dir)",
            },
            {
                "<leader>gG",
                function()
                    vim.cmd("lua require('lazyvim.util').terminal.open('lazygit')")
                end,
                desc = "Lazygit (cwd)",
            },
            {
                "<leader>gs",
                function()
                    require("telescope.builtin").git_status()
                end,
                desc = "Status",
            },
            {
                "<leader>gc",
                function()
                    require("telescope.builtin").git_commits()
                end,
                desc = "Commits",
            },
        },
        opts = {},
    },
}
