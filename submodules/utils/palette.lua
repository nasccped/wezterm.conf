local wz = require("wezterm")
local M = {}

--- Wezterm default color palette.
local default_palette = wz.color.get_default_colors()
--- My prefered colorscheme (with little changes).
local my_prefered = wz.color.get_builtin_schemes()["Adventure"]
    or default_palette

my_prefered.brights = my_prefered.brights or my_prefered.ansi

-- fully brightss
for i = #my_prefered.brights, 8 do
  if i > #my_prefered.brights then
    my_prefered.brights[i] = my_prefered.ansi[i]
  end
end

-- change magenta + white colors
my_prefered.foreground = "#E3E3E3"
my_prefered.ansi[2] = "#CE6C37"
my_prefered.brights[2] = "#F8692C"
my_prefered.ansi[6] = "#B888B3"
my_prefered.brights[6] = "#D2B1F1"
my_prefered.ansi[8] = "#eeeeee"
my_prefered.brights[8] = "#ffffff"

--- When foreground can't be found.
local default_foreground = default_palette.foreground
--- When background can't be found.
local default_background = default_palette.background

--- Unwrap the target `field` from a `t` table. If not found, returns
--- a `nil` value.
---
--- Field can be either a number (list index) or string (map).
---@param t? table
---@param field string | number
---@return string?
local function unwrap_field(t, field)
  local result = nil
  if type(t) ~= "table" then
    return result
  elseif type(field) == "number" and field <= #t or type(field) == "string" then
    result = t[field]
  end
  return result
end

--- Returns the foreground color from a resolved_palette table. If
--- table or required fields is `nil`, returns `default_foreground`
--- value (`#aaaaaa`).
---@param resolved_palette any
---@return string
function M.palette_get_foreground(resolved_palette)
  local result = resolved_palette and resolved_palette.foreground
  return result or default_foreground
end

--- Returns the background color from a resolved_palette table. If
--- table or required fields is `nil`, returns `default_background`
--- value (`#222222`).
---@param resolved_palette any
---@return string
function M.palette_get_background(resolved_palette)
  local result = resolved_palette and resolved_palette.background
  return result or default_background
end

--- Returns the ansi black color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"black"` string.
---@param resolved_palette any
---@return string
function M.palette_get_black(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 1)
      or default_palette.ansi[1]
end

--- Returns the ansi red color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"red"` string.
---@param resolved_palette any
---@return string
function M.palette_get_red(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 2)
      or default_palette.ansi[2]
end

--- Returns the ansi green color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"green"` string.
---@param resolved_palette any
---@return string
function M.palette_get_green(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 3)
      or default_palette.ansi[3]
end

--- Returns the ansi yellow color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"yellow"` string.
---@param resolved_palette any
---@return string
function M.palette_get_yellow(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 4)
      or default_palette.ansi[4]
end

--- Returns the ansi blue color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"blue"` string.
---@param resolved_palette any
---@return string
function M.palette_get_blue(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 5)
      or default_palette.ansi[5]
end

--- Returns the ansi magenta color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"magenta"` string.
---@param resolved_palette any
---@return string
function M.palette_get_magenta(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 6)
      or default_palette.ansi[6]
end

--- Returns the ansi cyan color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"cyan"` string.
---@param resolved_palette any
---@return string
function M.palette_get_cyan(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 7)
      or default_palette.ansi[7]
end

--- Returns the ansi white color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"white"` string.
---@param resolved_palette any
---@return string
function M.palette_get_white(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 8)
      or default_palette.ansi[8]
end

--- Returns the brights black color from a resolved_palette table. If
--- color result is `nil`, the ansi black will be returned. If it's
--- also `nil`, returns `"black"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_black(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.brights or resolved_palette.ansi
  end
  return unwrap_field(t, 1) or default_palette.brights[1]
end

--- Returns the brights red color from a resolved_palette table. If
--- color result is `nil`, the ansi red will be returned. If it's
--- also `nil`, returns `"red"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_red(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.brights or resolved_palette.ansi
  end
  return unwrap_field(t, 2) or default_palette.brights[2]
end

--- Returns the brights green color from a resolved_palette table. If
--- color result is `nil`, the ansi green will be returned. If it's
--- also `nil`, returns `"green"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_green(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.brights or resolved_palette.ansi
  end
  return unwrap_field(t, 3) or default_palette.brights[3]
end

--- Returns the brights yellow color from a resolved_palette table. If
--- color result is `nil`, the ansi yellow will be returned. If it's
--- also `nil`, returns `"yellow"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_yellow(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.brights or resolved_palette.ansi
  end
  return unwrap_field(t, 4) or default_palette.brights[4]
end

--- Returns the brights blue color from a resolved_palette table. If
--- color result is `nil`, the ansi blue will be returned. If it's
--- also `nil`, returns `"blue"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_blue(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.brights or resolved_palette.ansi
  end
  return unwrap_field(t, 5) or default_palette.brights[5]
end

--- Returns the brights magenta color from a resolved_palette table. If
--- color result is `nil`, the ansi magenta will be returned. If it's
--- also `nil`, returns `"magenta"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_magenta(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.brights or resolved_palette.ansi
  end
  return unwrap_field(t, 6) or default_palette.brights[6]
end

--- Returns the brights cyan color from a resolved_palette table. If
--- color result is `nil`, the ansi cyan will be returned. If it's
--- also `nil`, returns `"cyan"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_cyan(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.brights or resolved_palette.ansi
  end
  return unwrap_field(t, 7) or default_palette.brights[7]
end

--- Returns the brights white color from a resolved_palette table. If
--- color result is `nil`, the ansi white will be returned. If it's
--- also `nil`, returns `"white"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_white(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.brights or resolved_palette.ansi
  end
  return unwrap_field(t, 8) or default_palette.brights[8]
end

M.my_prefered_palette = my_prefered

return M
