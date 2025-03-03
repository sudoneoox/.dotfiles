return {
    -- NOTE: Text objects enhancement
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        opts = {
            -- custom settings
        },
        keys = {
            { "a", desc = "Around textobject", mode = { "x", "o" } },
            { "i", desc = "Inside textobject", mode = { "x", "o" } },
            { "al", desc = "Around last textobject", mode = { "o", "x" } },
            { "il", desc = "Inside last textobject", mode = { "o", "x" } },
            { "an", desc = "Around next textobject", mode = { "o", "x" } },
            { "in", desc = "Inside next textobject", mode = { "o", "x" } },
            { "g]", desc = 'Move to right "around"', mode = { "n", "x", "o" } },
            { "g[", desc = 'Move to left "around"', mode = { "n", "x", "o" } },
        },
    },
    -- NOTE: Auto-pairs for brackets, quotes, etc.
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {
            -- custom settings
        },
        keys = {
            {
                " up",
                function()
                    vim.cmd("lua MiniPairs.toggle()")
                end,
                desc = "Toggle Mini Pairs",
            },
        },
    },
}
