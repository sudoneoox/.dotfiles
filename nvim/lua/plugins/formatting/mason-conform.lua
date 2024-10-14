return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cpp = { "clang-format" },
        c = { "clang-format" },
        sql = { "sqlfmt" },
        ts = { "prettier" },
        js = { "prettier" },
        jsx = { "prettier" },
        py = { "autopep8" },
      },
    },
  },
  {
    "zapling/mason-conform.nvim",
  },
}
