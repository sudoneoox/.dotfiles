return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter", -- Load early
        version = false,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()
            local auto_select = true
            return {
                auto_brackets = {}, -- configure any filetype to auto add brackets
                completion = {
                    completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
                },
                preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
                    ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
                    ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                    ["<tab>"] = function(fallback)
                        return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
                    end,
                }),
                sources = cmp.config.sources({
                    { name = "lazydev" },
                    { name = "nvim_lsp" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
                formatting = {
                    format = function(entry, item)
                        local icons = LazyVim.config.icons.kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end

                        local widths = {
                            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
                            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
                        }

                        for key, width in pairs(widths) do
                            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
                            end
                        end

                        return item
                    end,
                },
                experimental = {
                    -- only show ghost text when we show ai completions
                    ghost_text = vim.g.ai_cmp and {
                        hl_group = "CmpGhostText",
                    } or false,
                },
                sorting = defaults.sorting,
            }
        end,
        main = "lazyvim.util.cmp",
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
