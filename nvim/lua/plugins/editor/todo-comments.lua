return {
{
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "LazyFile",
  opts = {
    keywords = {
        IMPORTANT =  {color = "#ff00cc", alt = {"IMP"}},
        TEST = {color="#ffb01f", alt = {"TT"}},
        DESCRIPTION = {color="#73ff00", alt = {"DESC"}},
      }


  },
  -- stylua: ignore
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
    { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME,IMPORTANT,TEST,DESCRIPTION<cr>", desc = "Todo/Fix/Fixme" },
  },
}
}
