return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          cpp = { "clang-format" },
          c = { "clang-format" },
          css = { "prettier" },
          html = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          python = { "isort", "black" },
        },
      })
    end,
  },
  {
    "zapling/mason-conform.nvim",
  },
}
