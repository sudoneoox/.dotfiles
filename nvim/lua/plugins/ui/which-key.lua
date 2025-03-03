return {
    -- Which-key for keybinding help
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show(" ", { mode = "n", auto = true })
                end,
                desc = "Buffer Keymaps (which-key)",
            },
            {
                "<C-W> ",
                function()
                    require("which-key").show(" ", { mode = "n", auto = true })
                end,
                desc = "Window Hydra Mode (which-key)",
            },
        },
        opts = {},
    },
}
