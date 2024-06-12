-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration
local config = wezterm.config_builder()

-- Windows Specific Config
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  local success, stdout, stderr = wezterm.run_child_process { 'cmd.exe', 'ver' }
  local major, minor, build, rev = stdout:match("Version ([0-9]+)%.([0-9]+)%.([0-9]+)%.([0-9]+)")
  local is_windows_11 = tonumber(build) >= 22000
  config.default_prog = { "pwsh.exe" }
end

-- Appearance
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 10
config.color_scheme = "Catppuccin Mocha"

-- Keybinds
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  -- splitting
  {
    mods = "LEADER",
    key = "-",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    mods = "LEADER",
    key = "\\",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  -- closing
  {
    mods = "LEADER",
    key = "x",
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  -- maximize
  {
    mods = "LEADER",
    key = "m",
    action = wezterm.action.TogglePaneZoomState
  },
}

return config
