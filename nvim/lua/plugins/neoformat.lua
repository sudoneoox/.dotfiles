return {
  "sbdchd/neoformat",
  config = function()
    -- Run formatter before saving the file
    vim.cmd([[
      augroup fmt
        autocmd!
        autocmd BufWritePre * undojoin | Neoformat
      augroup END
    ]])
  end,
}
