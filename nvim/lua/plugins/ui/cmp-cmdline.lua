return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter", -- Load early
        config = function()
            require("cmp").setup({
                -- Basic nvim-cmp configuration
                sources = {
                    { name = "buffer" },
                    { name = "path" },
                    -- Add more sources as needed
                },
                mapping = require("cmp").mapping.preset.insert({
                    -- Add your keymappings here
                }),
            })
        end,
    },
    {
        "hrsh7th/cmp-cmdline",
        event = "CmdlineEnter",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "cmdline" },
                },
            })
        end,
    },
    {
        "VonHeikemen/fine-cmdline.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })
            require("fine-cmdline").setup({
                cmdline = {
                    enable_keymaps = true,
                    smart_history = true,
                    prompt = ": ",
                },
                popup = {
                    position = {
                        row = "0%",
                        col = "50%",
                    },
                    size = {
                        width = "30%",
                    },
                    border = {
                        style = "rounded",
                        text = {
                            top = "Command",
                            top_align = "center",
                        },
                    },
                    win_options = {
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                    },
                },
                hooks = {
                    before_mount = function(input)
                        -- Placeholder for any setup before the prompt is mounted
                    end,
                    after_mount = function(input)
                        -- Placeholder for any setup after the prompt is mounted
                    end,
                    set_keymaps = function(imap, feedkeys)
                        -- Placeholder for custom keymaps
                    end,
                },
            })
        end,
    },
}
