local dir = 'plugins.lsp.'

return {
  require(dir .. 'disabled-plugins'),
  require(dir .. 'lazy-lsp'),

}
