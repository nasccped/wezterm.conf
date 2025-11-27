local M = {}

--- When foreground can't be found.
local default_foreground = "#aaaaaa"
--- When background can't be found.
local default_background = "#222222"

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
      or "black"
end

--- Returns the ansi red color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"red"` string.
---@param resolved_palette any
---@return string
function M.palette_get_red(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 2)
      or "red"
end

--- Returns the ansi green color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"green"` string.
---@param resolved_palette any
---@return string
function M.palette_get_green(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 3)
      or "green"
end

--- Returns the ansi yellow color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"yellow"` string.
---@param resolved_palette any
---@return string
function M.palette_get_yellow(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 4)
      or "yellow"
end

--- Returns the ansi blue color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"blue"` string.
---@param resolved_palette any
---@return string
function M.palette_get_blue(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 5)
      or "blue"
end

--- Returns the ansi magenta color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"magenta"` string.
---@param resolved_palette any
---@return string
function M.palette_get_magenta(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 6)
      or "magenta"
end

--- Returns the ansi cyan color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"cyan"` string.
---@param resolved_palette any
---@return string
function M.palette_get_cyan(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 7)
      or "cyan"
end

--- Returns the ansi white color from a resolved_palette table. If
--- table or required fields is `nil`, returns `"white"` string.
---@param resolved_palette any
---@return string
function M.palette_get_white(resolved_palette)
  return resolved_palette
      and unwrap_field(resolved_palette.ansi, 8)
      or "white"
end

--- Returns the bright black color from a resolved_palette table. If
--- color result is `nil`, the ansi black will be returned. If it's
--- also `nil`, returns `"black"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_black(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.bright or resolved_palette.ansi
  end
  return unwrap_field(t, 1) or "black"
end

--- Returns the bright red color from a resolved_palette table. If
--- color result is `nil`, the ansi red will be returned. If it's
--- also `nil`, returns `"red"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_red(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.bright or resolved_palette.ansi
  end
  return unwrap_field(t, 2) or "red"
end

--- Returns the bright green color from a resolved_palette table. If
--- color result is `nil`, the ansi green will be returned. If it's
--- also `nil`, returns `"green"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_green(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.bright or resolved_palette.ansi
  end
  return unwrap_field(t, 3) or "green"
end

--- Returns the bright yellow color from a resolved_palette table. If
--- color result is `nil`, the ansi yellow will be returned. If it's
--- also `nil`, returns `"yellow"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_yellow(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.bright or resolved_palette.ansi
  end
  return unwrap_field(t, 4) or "yellow"
end

--- Returns the bright blue color from a resolved_palette table. If
--- color result is `nil`, the ansi blue will be returned. If it's
--- also `nil`, returns `"blue"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_blue(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.bright or resolved_palette.ansi
  end
  return unwrap_field(t, 5) or "blue"
end

--- Returns the bright magenta color from a resolved_palette table. If
--- color result is `nil`, the ansi magenta will be returned. If it's
--- also `nil`, returns `"magenta"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_magenta(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.bright or resolved_palette.ansi
  end
  return unwrap_field(t, 6) or "magenta"
end

--- Returns the bright cyan color from a resolved_palette table. If
--- color result is `nil`, the ansi cyan will be returned. If it's
--- also `nil`, returns `"cyan"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_cyan(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.bright or resolved_palette.ansi
  end
  return unwrap_field(t, 7) or "cyan"
end

--- Returns the bright white color from a resolved_palette table. If
--- color result is `nil`, the ansi white will be returned. If it's
--- also `nil`, returns `"white"` string.
---@param resolved_palette any
---@return string
function M.palette_get_b_white(resolved_palette)
  local t = nil
  if resolved_palette then
    t = resolved_palette.bright or resolved_palette.ansi
  end
  return unwrap_field(t, 8) or "white"
end

return M
