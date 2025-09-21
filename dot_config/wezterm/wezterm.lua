local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- ui
config.automatically_reload_config = true
config.font_size = 17.0
config.line_height = 1.0
config.font = wezterm.font("HackGen Console NF")
config.use_ime = true
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = false
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}


config.initial_cols = 130
config.initial_rows = 38
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"
  local edge_background = "none"
  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
  end
  local edge_foreground = background
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

-- keybinds (keybinds.lua)
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

-- タブバーの右側にMODE名とWORKSPACE名を表示
wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  local workspace = window:active_workspace()
  -- MODEとWORKSPACEの両方を表示
  local text = {}
  if name then
    table.insert(text, { Foreground = { Color = "#9ece6a" } })  -- MODE名の色
    table.insert(text, { Text = "MODE: " .. name })
  end
  if workspace then
    if #text > 0 then
      table.insert(text, { Text = " | " })
    end
    table.insert(text, { Foreground = { Color = "#7dcfff" } })  -- WORKSPACE名の色
    table.insert(text, { Text = "WORKSPACE: " .. workspace })
  end
  window:set_right_status(wezterm.format(text))
end)

local background_image = "/Users/shimizutoorushin/.config/wezterm/sora.png"

config.background = {
  -- グラデーションレイヤー
  {
    source = {
      Gradient = {
        colors = { "#124354", "#001522" },
        orientation = {
          Linear = { angle = -30.0 },
        },
      },
    },
    opacity = 1.0,
  },
  -- 画像レイヤー
  {
    source = {
      File = background_image,
    },
    opacity = 0.35,
    vertical_align = "Middle",
    horizontal_align = "Right",
    horizontal_offset = "200px",
    repeat_x = "NoRepeat",
    repeat_y = "NoRepeat",
    width = "1431px",
    height = "1900px",
  },
}

config.window_background_opacity = 0.7
config.macos_window_background_blur = 20

config.window_background_gradient = {
  colors = { "#000000" },
}

return config