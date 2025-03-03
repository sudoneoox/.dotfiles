return {
  -- stylua: ignore
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash", "c", "html", "javascript", "json", "lua", "luadoc", "markdown",
        "python", "query", "regex", "vim", "vimdoc", "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    keys = {
      { "<leader>uT", function() vim.cmd("TSBufToggle highlight") end, desc = "Toggle Treesitter Highlight" },
    },
  },
  -- stylua: ignore
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
      keys = {
    },
  },

    {
        "windwp/nvim-ts-autotag",
        event = "LazyFile",
        opts = {},
    },
}
