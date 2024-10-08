local dir = "plugins.formatting."
return {
  require(dir .. "disabled-plugins"),
  require(dir .. "neoformat"),
}
