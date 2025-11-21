local wz = require("wezterm")
local config = wz.config_builder()

--- Deeply extends the source table into the target table and then,
--- returns the new target.
---@param target table
---@param source table
---@return table
local function deep_extend(target, source)
  for k, v in pairs(source) do
    if type(v) == "table" and type(target[k]) == "table" then
      target[k] = deep_extend(target[k], v)
    else
      target[k] = v
    end
  end
  return target
end

--- Extends the config table by placing the provided value into the
--- designed field.
---@param field string
---@param value any
local function extend(field, value)
  if config[field] ~= nil then
    config[field] = deep_extend(config[field], value)
  else
    config[field] = value
  end
end

---------------------------------------------------------------------
-- visual
---------------------------------------------------------------------
extend("font", wz.font_with_fallback({
  { family = "Iosevka Term",   weight = "DemiBold" },
  { family = "Iosevka",        weight = "Bold" },
  { family = "JetBrains Mono", weight = "Bold" },
  { family = "Terminus",       weight = "Bold" },
  "Noto Color Emoji",
  "monospace",
}))
extend("font_size", 13.0)
extend("colors", {
  -- TODO: add ansy/bright colors
  foreground = "#cccccc",
  background = "#1e1e1e",
  -- cursor colors
  cursor_bg = "#cccccc",
  cursor_fg = "#111111",
  -- selection colors
  selection_fg = "#1e1e1e",
  selection_bg = "#ffffff",
})
---------------------------------------------------------------------
-- key maps
---------------------------------------------------------------------
extend("leader", {
  key = "Space",
  mods = "CTRL",
  timeout_milliseconds = 1000
})
extend("keys", {
  -- split pane horizontally by pressing LEADER + /
  {
    key = "/",
    mods = "LEADER",
    action = wz.action.SplitHorizontal({
      domain = "CurrentPaneDomain"
    })
  },
  -- split pane vertically by pressing LEADER + ?
  {
    key = "?",
    mods = "LEADER",
    action = wz.action.SplitVertical({
      domain = "CurrentPaneDomain"
    })
  },
  -- go copy mode by pressing LEADER + [
  {
    key = "[",
    mods = "LEADER",
    action = wz.action.ActivateCopyMode,
  }
})
-- TODO: add other key binds

return config
