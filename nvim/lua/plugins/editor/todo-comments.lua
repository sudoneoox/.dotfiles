return {
    -- NOTE: Todo Comment Highlighting
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = "LazyFile",
        opts = {
            keywords = {
                IMPORTANT = { color = "#ff00cc", alt = { "CRITICAL" } },
                DESCRIPTION = { color = "#73ff00", alt = { "DESC" } },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                HACK = { icon = " ", color = "warning" },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            },
        },

        keys = {
            { "<leader>ct", "", desc = "+Todo Comments", mode = { "n", "v" } },
            { "<leader>cts", "", desc = "+Todo Comments Search", mode = { "n", "v" } },
            { "<leader>ctx", "", desc = "+Todo Comments Trouble", mode = { "n", "v" } },

            {
                "<leader>ct]",
                function()
                    require("todo-comments").jump_next()
                end,
                desc = "Next Todo Comment",
            },
            {
                "<leader>ct[",
                function()
                    require("todo-comments").jump_prev()
                end,
                desc = "Previous Todo Comment",
            },
            { "<leader>ctxt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
            {
                "<leader>ctxT",
                "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
                desc = "Todo/Fix/Fixme (Trouble)",
            },
            { "<leader>ctst", "<cmd>TodoTelescope<cr>", desc = "Todo" },
            {
                "<leader>ctsT",
                "<cmd>TodoTelescope keywords=TODO,FIX,FIXME,IMPORTANT,TEST,DESCRIPTION<cr>",
                desc = "Todo/Fix/Fixme",
            },
        },
    },
}
