local wz = require("wezterm")
local config = wz.config_builder()

--- Operates the `require` function on a given path. Note that:
--- 1. placing `"submodules"` at beginning isn't necessary since all
---    submodules are within the `submodules` mod.
--- 2. you must use forward slash (`/`) when passing the path instead
---    dot (`.`) (wezterm doesn't allow unsafe C function call).
---@param path string Submodule path to require.
---@return table
local function submodule_require(path)
  return require("submodules/" .. path)
end

-- load config submodules -------------------------------------------
local utils = submodule_require("utils")

--- Extends the local `config` table. The `content` param is expected
--- to be a table, since it won't be pushed to the config, but will
--- override the existing value, instead.
---@param content table
local function config_extend(content)
  utils.panic_on(
    type(content) ~= "table",
    "config_extend: `content` param is expected to be a `table`"
  )
  for k, v in pairs(content) do
    if type(config[k]) == "table" and type(v) == "table" then
      config[k] = utils.table_deep_extend(config[k], v)
    else
      config[k] = v
    end
  end
end

config_extend(submodule_require("fonts"))
config_extend(submodule_require("keymaps"))
config_extend(submodule_require("ui"))

-- this var is used in the comment bellow. addressed mux to `_`, so
-- lsp can stop arguing about it.
local mux = wz.mux
local _ = mux

-- enable full screen on start up -----------------------------------
-- Windows works not good at all with this (can't resize later +
-- doesn't hide task bar) but performs good in MacOS and X11,
-- according with wezterm author (https://github.com/wezterm/wezterm/issues/284#issuecomment-1177628870).
-- -- consider uncommenting to enable it.
-- wz.on("gui-startup", function()
--   local _, _, window = mux.spawn_window{}
--   window:gui_window():maximize()
-- end)

return config
