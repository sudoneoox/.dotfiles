local dir = "plugins.editor."
return {
    require(dir .. "latex"),
    require(dir .. "todo-comments"),
    require(dir .. "mini"),
    require(dir .. "ts-comments"),
    require(dir .. "disabled-plugins"),
    require(dir .. "leetcode"),
}
