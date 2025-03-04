return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = function(_, opts)
            opts.views = {
                cmdline_popup = { position = { row = 35, col = "50%" } },
                cmdline_popupmenu = { position = { row = 38, col = "50%" } },
                mini = { win_options = { winblend = 0 } },
            }
            opts.lsp = { progress = { enabled = false }, hover = { silent = true } }
            opts.presets.lsp_doc_border = true

            -- supressing notifs
            opts.routes = {
                { filter = { event = "msg_show", find = "written" } },
                { filter = { event = "msg_show", find = "yanked" } },
                { filter = { event = "msg_show", find = "%d+L, %d+B" } },
                { filter = { event = "msg_show", find = "; after #%d+" } },
                { filter = { event = "msg_show", find = "; before #%d+" } },
                { filter = { event = "msg_show", find = "%d fewer lines" } },
                { filter = { event = "msg_show", find = "%d more lines" } },
                { filter = { event = "msg_show", find = "%d lines indented" } },
                { filter = { event = "msg_show", find = "%d lines moved" } },
                { filter = { event = "msg_show", find = "<ed" } },
                { filter = { event = "msg_show", find = ">ed" } },
                { filter = { event = "lsp", kind = "progress", find = "jdtls" } },
            }
        end,
    -- stylua: ignore
        keys = {
          { "<leader>n", "", desc="+noice notifications", mode="n"},
          { "<leader>nt", function() require("telescope").extensions.notify.notify() end, desc = "Notification History" },
          { "<leader>np", function() require("telescope").extensions.noice.telescope() end, desc = "Noice Picker (Telescope/FzfLua)" },
          { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
          { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
          { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
          { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
          { "<leader>nD", function() require("notify").dismiss() end, desc = "Dismiss All Notifications" },

          { "<leader>sn", false},
          { "<leader>snt", false},
          { "<leader>snp", false},
          { "<leader>snd", false},
          { "<leader>sna", false},
          { "<leader>snh", false},
          { "<leader>snl", false},
          { "<leader>snD", false},

        },
    },
}
