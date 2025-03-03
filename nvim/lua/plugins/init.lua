local plugins = {}

local ui_plugins = require("plugins.ui")
local util_plugins = require("plugins.util")
local lsp_plugins = require("plugins.lsp")
local colorschemes = require("plugins.colorschemes")
local coding = require("plugins.coding")
local formattings = require("plugins.formatting")
local treesitter_plugins = require("plugins.treesitter")
local linter_plugins = require("plugins.linter")
local editor = require("plugins.editor")

for _, plugin in ipairs(colorschemes) do
    table.insert(plugins, plugin)
end

for _, plugin in ipairs(coding) do
    table.insert(plugins, plugin)
end

for _, plugin in ipairs(treesitter_plugins) do
    table.insert(plugins, plugin)
end

for _, plugin in ipairs(linter_plugins) do
    table.insert(plugins, plugin)
end

for _, plugin in ipairs(editor) do
    table.insert(plugins, plugin)
end

for _, plugin in ipairs(lsp_plugins) do
    table.insert(plugins, plugin)
end

for _, plugin in ipairs(formattings) do
    table.insert(plugins, plugin)
end

for _, plugin in ipairs(util_plugins) do
    table.insert(plugins, plugin)
end

for _, plugin in ipairs(ui_plugins) do
    table.insert(plugins, plugin)
end

return plugins
