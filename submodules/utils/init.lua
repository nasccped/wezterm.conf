local tbl = require("submodules/utils/table")
local panic = require("submodules/utils/panic")
local tabs = require("submodules/utils/tabs")
local palette = require("submodules/utils/palette")
local M = {}

-- Add the function manually (allow lsp docs).

-- panic ------------------------------------------------------------
M.panic_on = panic.panic_on

-- table ------------------------------------------------------------
M.table_deep_extend = tbl.table_deep_extend

-- tabs (wezterm tab) -----------------------------------------------
M.tab_get_title = tabs.tab_get_title

-- palette ----------------------------------------------------------
M.palette_get_foreground = palette.palette_get_foreground
M.palette_get_background = palette.palette_get_background
M.palette_get_black = palette.palette_get_black
M.palette_get_red = palette.palette_get_red
M.palette_get_green = palette.palette_get_green
M.palette_get_yellow = palette.palette_get_yellow
M.palette_get_blue = palette.palette_get_blue
M.palette_get_magenta = palette.palette_get_magenta
M.palette_get_cyan = palette.palette_get_cyan
M.palette_get_white = palette.palette_get_white
M.palette_get_b_black = palette.palette_get_b_black
M.palette_get_b_red = palette.palette_get_b_red
M.palette_get_b_green = palette.palette_get_b_green
M.palette_get_b_yellow = palette.palette_get_b_yellow
M.palette_get_b_blue = palette.palette_get_b_blue
M.palette_get_b_magenta = palette.palette_get_b_magenta
M.palette_get_b_cyan = palette.palette_get_b_cyan
M.palette_get_b_white = palette.palette_get_b_white

return M
