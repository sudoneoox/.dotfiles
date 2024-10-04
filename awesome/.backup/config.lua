local apps = {
    launcher = "rofi -show-icons -modi windowcd,window,drun -show drun -filter ",
    xrandr = "lxrandr",
    screenshot = "flameshot",
    volume = "pavucontrol",
    appearance = "lxappearance",
    browser = "firefox",
    fileexplorer = "thunar",
    discord = "discord",
    editor = "nano",
    ide = "code",
    settings = "code /home/diego/.config/awesome/"
}

local terminal_cmds = {
    -- {
    --   cmd = 'journalctl -n 15 --no-pager -u "systemd-*"'
    -- },
    -- {
    --   cmd = 'journalctl -n 30 --no-pager'
    -- },
    -- {
    --   cmd = 'notes_sync',
    --   timeout = 100000
    -- },
    -- {
    --   cmd = 'ls'
    -- },
    -- {
    --   cmd = 'sh chat-gpt "Describe cons and pros of awesomewm." 1.0',
    --   timeout = 100000
    -- },
    -- {
    --   cmd = 'sh chat-gpt "${input}" 1.0',
    --   timeout = 100000,
    --   prompt = 'Enter question for chat-gpt:'
    -- },
    -- {
    --   cmd = 'echo "${input}"',
    --   prompt = 'Enter text for echo:'
    -- }
}

local user = {
    terminal = "kitty",
    terminal2nd = "kitty",
}

local config = {
  apps = apps,
  user = user,
  terminal_cmds = terminal_cmds,
  weather_coordinates = { 49.261749, 13.903450 },
  dashboard_monitor_storage = {"/", "/home", "/swap", "/root" },
  main_panel = 'wibar', -- variants: wibar, polybar, none
  --{{{ Features Activity
  dashboard_enabled = true,
  desktop_enabled = false,
  active_corners_enabled = false,
  --}}}
}

return config
