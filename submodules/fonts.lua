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
--- top one to the bottom one.
local favorite_font_fallback = {
  { family = "Iosevka Term",   weight = "Regular" },
  { family = "Iosevka",        weight = "Regular" },
  { family = "JetBrains Mono", weight = "Regular" },
  { family = "Terminus",       weight = "Regular" },
  "Noto Color Emoji",
  "monospace",
}

--- Push a new font into the `font_table`. Note that the `font` param
--- expects a type present within the `favorite_font_fallback`
--- (`table` or `string`).
---
--- This function automatically set the `harfbuzz_features` as
--- disabled.
---@param font table|string Font to be insert.
local function push_into_font_table(font)
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
  font_table[#font_table + 1] = font
end

-- Pushing fonts into `font_table`.
for _, fav_font in ipairs(favorite_font_fallback) do
  push_into_font_table(fav_font)
end

-- set font fields --------------------------------------------------
M.font = wz.font_with_fallback(font_table)
M.font_size = font_size

return M
