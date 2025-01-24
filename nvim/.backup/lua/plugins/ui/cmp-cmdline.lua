return {
  {
    "hrsh7th/nvim-cmp",
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
  },
  {
    "VonHeikemen/fine-cmdline.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })
      require('fine-cmdline').setup({
        cmdline = {
          enable_keymaps = true,
          smart_history = true,
          prompt = ': '
        },
        popup = {
          position = {
            row = '10%',
            col = '50%',
          },
          size = {
            width = '60%',
          },
          border = {
            style = 'rounded',
          },
          win_options = {
            winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
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
