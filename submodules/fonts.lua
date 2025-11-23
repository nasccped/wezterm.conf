local M = {}
local panic_on = require("submodules/utils/panic").panic_on
local wz = require("wezterm")

--- Default `table` containing the `harfbuzz_features` as disabled.
--- You can read more at: https://wezterm.org/config/font-shaping.html
local disabled_harfbuzz = { "calt=0", "clig=0", "liga=0" }
--- Prefered font size (targeting "Iosevka" fonts. May change
--- depending on current font).
local font_size = 13.0
--- Font table (gonna be placed at `M.font` field). Init as empty and
--- then, each font variant at `favorite_font_fallback` is pushed
--- into it. Read also the `push_font_into_table` function which
--- actually does the job.
local font_table = {}

--- My favorite fonts. Note that the precedence will follows from to
--- top one to the bottom one. The `weight` field is already set to
--- (my favorites, btw).
local favorite_font_fallback = {
  { family = "Iosevka Term",   weight = "DemiBold" },
  { family = "Iosevka",        weight = "Bold" },
  { family = "JetBrains Mono", weight = "Bold" },
  { family = "Terminus",       weight = "Bold" },
  "Noto Color Emoji",
  "monospace",
}

--- Push a new font into the table. Note that the `font` param
--- expects a type present within the `favorite_font_fallback`
--- (`table` or `string`).
---
--- This function automatically set the `harfbuzz_features` as
--- disabled.
---@param tbl table Table to insert font into.
---@param font table|string Font to be insert.
local function push_font_into_table(tbl, font)
  panic_on(
    type(tbl) ~= "table",
    "push_font_into_table: `tbl` param must be a table"
  )
  if type(font) == "string" then
    font = {
      family = font,
      harfbuzz_features = disabled_harfbuzz
    }
  elseif type(font) == "table" then
    font.harfbuzz_features = disabled_harfbuzz
  else
    panic_on(
      true,
      "push_font_into_table: `font` param must be either `string` or `table`"
    )
  end
  tbl[#tbl + 1] = font
end

-- Pushing fonts into `font_table`.
for _, fav_font in ipairs(favorite_font_fallback) do
  push_font_into_table(font_table, fav_font)
end

-- set font fields --------------------------------------------------
M.font = wz.font_with_fallback(font_table)
M.font_size = font_size

return M
