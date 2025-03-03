return {
    {
        "neovim/nvim-lspconfig",
        event = "LazyFile",
    -- stylua: ignore
      keys = {
        -- { "<leader>cd", function() vim.diagnostic.open_float() end, desc = "Line Diagnostics" },
        { "<leader>uh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "Toggle Inlay Hints" },
        -- { "[d",function() vim.diagnostic.goto_prev() end, desc = "Prev Diagnostic" },
        -- { "]d", function() vim.diagnostic.goto_next() end, desc = "Next Diagnostic" },
        -- { "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, desc = "Prev Warning" },
        -- { "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, desc = "Next Warning" },
        -- { "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Prev Error" },
        -- { "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Next Error" },
        -- { "<C-W>d", function() vim.diagnostic.open_float() end, desc = "Show diagnostics under the cursor" },
      },
    },
}
