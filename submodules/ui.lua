local wz = require("wezterm")
local utils = require("submodules.utils")
local M = {}
--- If tab bar is enabled by default.
local enable_tab_bar = true
--- Window decor mode.
local window_decorations = "RESIZE"
--- My current colorscheme (intended to change)
local color_scheme = "Adventure"
--- Disable fancy bar.
local use_fancy_tab_bar = false
--- Padding values.
local window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}
--- Disable new tab button.
local show_new_tab_button_in_tab_bar = false

--- tab title formating
wz.on("format-tab-title", function(tab, tabs, _, config, _, _)
  local title = utils.tab_get_title(tab)
  local ind = tab.tab_index + 1
  local palette = config.resolved_palette
  local bg = utils.palette_get_yellow(palette)
  local fg = utils.palette_get_black(palette)
  local term_bg = utils.palette_get_background(palette)
  if tab.is_active then
    bg = utils.palette_get_b_red(palette)
    fg = utils.palette_get_b_white(palette)
  end
  return {
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = string.format(" %d:%s ", ind, title) },
    { Background = { Color = term_bg } },
    { Text = ind >= #tabs and "" or " "  },
  }
end)

--- right status
wz.on("update-status", function(window, _)
  local time = wz.strftime("%H:%M")
  local day = wz.strftime("%e")
  local month = wz.strftime("%b")
  local year = wz.strftime("%Y")
  local cfg = window:effective_config()
  local palette = cfg.resolved_palette
  local white = utils.palette_get_b_white(palette)
  local blue = utils.palette_get_blue(palette)
  local black = utils.palette_get_b_black(palette)
  local cyan = utils.palette_get_b_cyan(palette)
  window:set_right_status(wz.format({
    { Foreground = { Color = white } },
    { Background = { Color = blue } },
    { Text = string.format(" %s ", time) },
    { Foreground = { Color = black } },
    { Background = { Color = cyan } },
    { Text = string.format(" %s %s, %s ", month, day, year) }
  }))
end)

M.enable_tab_bar = enable_tab_bar
M.window_decorations = window_decorations
M.color_scheme = color_scheme
M.use_fancy_tab_bar = use_fancy_tab_bar
M.show_new_tab_button_in_tab_bar = show_new_tab_button_in_tab_bar
M.window_padding = window_padding

return M
