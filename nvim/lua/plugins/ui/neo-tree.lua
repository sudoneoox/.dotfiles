return {
    -- File explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
    -- stylua: ignore
        keys = {
            { "<leader>fe", function() require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").root.get() }) end, desc = "Explorer NeoTree (Root Dir)" },
            { "<leader>fE", function() require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() }) end, desc = "Explorer NeoTree (cwd)" },
            { "<leader>be", function() require("neo-tree.command").execute({ source = "buffers", toggle = true }) end, desc = "Buffer Explorer" },
            { "<leader>ge", function() require("neo-tree.command").execute({ source = "git_status", toggle = true }) end, desc = "Git Explorer" },
        },
        opts = {},
    },
}
