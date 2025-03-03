local dir = "plugins.lsp."

return {
    require(dir .. "nvim-docs-view"),
    require(dir .. "mason"),
    require(dir .. "nvim-lspconfig"),
}
