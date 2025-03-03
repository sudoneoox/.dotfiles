return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {},
        },
        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format()
                end,
                desc = "Format",
                mode = { "n", "v" },
            },
            {
                "<leader>uF",
                function()
                    vim.b.autoformat = not vim.b.autoformat
                end,
                desc = "Toggle Auto Format (Buffer)",
            },
            {
                "<leader>uf",
                function()
                    vim.g.autoformat = not vim.g.autoformat
                end,
                desc = "Toggle Auto Format (Global)",
            },
            {
                "<leader>cF",
                function()
                    require("conform").format({ formatters = { "injected" } })
                end,
                desc = "Format Injected Langs",
                mode = { "n", "v" },
            },
        },
    },
}
