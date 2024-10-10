function codelldb --description "lldb server"
  while true
    $HOME/.local/share/nvim/mason/bin/codelldb --port 13000
    sleep 1
  end
end
