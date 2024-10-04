return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")

    -- Keybindings for searching different directories
    vim.keymap.set("n", "<leader>fh", function()
      builtin.find_files({ cwd = vim.fn.expand("~") })
    end, { desc = "Find files in the home directory" })
  end,
}
