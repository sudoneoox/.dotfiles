local plugins = {}

local ui_plugins = require("plugins.ui")
local util_plugins = require('plugins.utils')
local lsp_plugins = require('plugins.lsp')
local colorschemes = require('plugins.colorschemes')

for _, plugin in ipairs(colorschemes) do 
    table.insert(plugins, plugin)
end

for _, plugin in ipairs(lsp_plugins) do 
    table.insert(plugins, plugin)
end

for _, plugin in ipairs(util_plugins) do 
    table.insert(plugins, plugin)
end


for _, plugin in ipairs(ui_plugins) do 
    table.insert(plugins, plugin)
end

return plugins
