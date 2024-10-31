function run --description "Make file executable, then run it"
  chmod +x "$argv"
  eval "./$argv"
end

