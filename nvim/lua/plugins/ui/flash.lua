return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
    -- stylua: ignore
        keys = {
          { "s", function() require("flash").jump() end, desc = "Flash", mode = { "n", "x", "o" } },
          { "S", function() require("flash").treesitter() end, desc = "Flash Treesitter", mode = { "n", "x", "o" } },
          { "r", function() require("flash").remote() end, desc = "Remote Flash", mode = "o" },
          { "R", function() require("flash").treesitter_search() end, desc = "Treesitter Search", mode = { "o", "x" } },
          { "f", function() require("flash").jump({ search = { forward = true, wrap = false, multi_window = false } }) end, mode = { "n", "x", "o" } },
          { "F", function() require("flash").jump({ search = { forward = false, wrap = false, multi_window = false } }) end, mode = { "n", "x", "o" } },
          { "t", function() require("flash").jump({ search = { forward = true, wrap = false, multi_window = false } }) end, mode = { "n", "x", "o" } },
          { "T", function() require("flash").jump({ search = { forward = false, wrap = false, multi_window = false } }) end, mode = { "n", "x", "o" } },
        },
    },
}
