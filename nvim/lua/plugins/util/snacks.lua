return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = function(_, opts)
            opts.animate = {}
            opts.bigfile = {
                enabled = true,
                notify = true,
                size = 1.5 * 1024 * 1024,
                line_length = 3000,
            }

            -- NOTE: DASHBOARD
            opts.dashboard = {
                enabled = true,
                preset = {
                    header = [[
            ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
            ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
            ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
            ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
            ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
            ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
                  ]],
              -- stylua: ignore
                keys = {
                      { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                      { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                      { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                      { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                  },
                },
                sections = {
                    { section = "header" },
                    { pane = 2, section = "terminal", cmd = "colorscript -e square", height = 5, padding = 1 },
                    { icon = " ", title = "Keymaps", section = "keys", gap = 1, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Recent Files",
                        section = "recent_files",
                        indent = 2,
                        padding = 1,
                    },
                    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = function()
                            return Snacks.git.get_root() ~= nil
                        end,
                        cmd = "git status --short --branch --renames",
                        height = 5,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                    },
                    { section = "startup" },
                },
            }
            opts.explorer = { enabled = false }
            opts.indent = { enabled = true }
            opts.image = {
                enabled = true,
                formats = { "png", "jpeg", "jpg", "gif" },
            }
            opts.input = { enabled = true }
            opts.picker = { enabled = true }

            Snacks.profiler.highlight(false)
            opts.profiler = {}
            opts.notifier = { enabled = true }
            opts.quickfile = { enabled = true }
            opts.scope = { enabled = true }
            opts.scroll = { enabled = true }
            opts.statuscolumn = { enabled = true }
            opts.words = { enabled = true }
            opts.zen = {}
        end,
    },
}
