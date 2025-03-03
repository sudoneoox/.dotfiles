return {
    "amrbashir/nvim-docs-view",
    lazy = true,
    cmd = "DocsViewToggle",
    opts = {
        position = "bottom",
        height = 8,
    },
    keys = {
        { "<leader>i", "", desc = "+lspInfo", mode = { "n", "v" } },
        {
            "<leader>idv",
            function()
                require("docs-view"):toggle()
            end,
            desc = "Nvim Docs View Toggle",
        },
        {
            "<leader>idu",
            function()
                require("docs-view"):update()
            end,
            desc = "Nvim Docs View Update",
        },
    },
}
