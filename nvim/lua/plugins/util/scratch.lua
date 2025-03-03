return {
    {
        "mnacamura/snacks.nvim",
        keys = {
            {
                "<leader>.",
                function()
                    vim.cmd("Snacks")
                end,
                desc = "Toggle Scratch Buffer",
            },
            {
                "<leader>S",
                function()
                    vim.cmd("SnacksList")
                end,
                desc = "Select Scratch Buffer",
            },
        },
        opts = {},
    },
}
