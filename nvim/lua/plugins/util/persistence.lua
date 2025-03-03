return {
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        keys = {
            {
                "<leader>ql",
                function()
                    require("persistence").load({ last = true })
                end,
                desc = "Restore Last Session",
            },
            {
                "<leader>qS",
                function()
                    require("persistence").load()
                end,
                desc = "Select Session",
            },
            {
                "<leader>qs",
                function()
                    require("persistence").load()
                end,
                desc = "Restore Session",
            },
            {
                "<leader>qd",
                function()
                    require("persistence").stop()
                end,
                desc = "Don't Save Current Session",
            },
        },
        opts = {},
    },
}
