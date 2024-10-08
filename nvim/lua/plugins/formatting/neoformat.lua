return {
  "sbdchd/neoformat",
  config = function()
    -- Ensure Neoformat is loaded
    vim.cmd([[packadd neoformat]])

    -- Run formatter before saving the file
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function()
        vim.cmd("undojoin | Neoformat")
      end,
      group = vim.api.nvim_create_augroup("NeoformatAutoFormat", { clear = true }),
    })
  end,
}
