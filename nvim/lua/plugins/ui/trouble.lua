return {
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = { "TroubleToggle", "Trouble" },
    -- stylua: ignore
        keys = {
          { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
          { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
          { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
          { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
          { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
          { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
          { "<leader>xT", function() require("trouble").toggle({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme (Trouble)" },
          { "<leader>xt", function() require("trouble").toggle({ keywords = { "TODO" } }) end, desc = "Todo (Trouble)" },
          { "[q", function() require("trouble").previous({ skip_groups = true, jump = true }) end, desc = "Previous Trouble/Quickfix Item" },
          { "]q", function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Next Trouble/Quickfix Item" },
        },
        opts = {},
    },
}
