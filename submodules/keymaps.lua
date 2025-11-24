local M = {}
local wz = require("wezterm")
local action = wz.action
local panic_on = require("submodules/utils/panic").panic_on
local pane_domain = "CurrentPaneDomain"
--- Default Timeout Milliseconds value.
local timeout_m = 1000
--- Default Leader Key.
local leader_key = {
  key = "Space",
  mods = "CTRL",
  timeout_milliseconds = timeout_m
}
--- Stores the key maps to be added into wezterm `key` field.
local key_maps = {}

--- Push a new key table into the `key_maps` list.
---@param t table
function key_maps.push(t)
  panic_on(
    type(t) ~= "table",
    "key_maps.push: `t` param is expected to be a table"
  )
  key_maps[#key_maps + 1] = t
end

--- Push a new key map into the `key_maps` table which operates with
--- the `LEADER` key. You can optionally add another mod key
--- (through the `other_mod` param) like `LEADER` + `MOD` combo.
---@param key string
---@param other_mod? string
---@param act any Action to be done.
local function append_leader_combo(key, other_mod, act)
  panic_on(
    type(other_mod) ~= "string" and type(other_mod) ~= "nil",
    "append_leader_combo: `other_mod` is expected to be a either a string or nil value"
  )
  panic_on(
    other_mod == "LEADER",
    "append_leader_combo: `other_mod` can't be `LEADER` since it'll be a repeated combination"
  )
  local t = {
    key = key,
    mods = other_mod and other_mod .. "|LEADER" or "LEADER",
    action = act
  }
  key_maps.push(t)
end

--- Key map that operates with no mods key (`mods = "NONE"`).
--- Automatically pushes to `key_maps`.
---@param key string
---@param act any wezterm.action to be done.
local function append_simple_key(key, act)
  panic_on(
    type(key) ~= "string",
    "append_simple_key: `key` is expected to be a string"
  )
  local t = {
    key = key,
    mods = "NONE",
    action = act
  }
  key_maps.push(t)
end

-- splitting --------------------------------------------------------
-- horizontal
append_leader_combo("|", "SHIFT", action.SplitHorizontal({ domain = pane_domain }))
-- vertical
append_leader_combo("\\", nil, action.SplitVertical({ domain = pane_domain }))
-- closing
append_leader_combo("c", nil, action.CloseCurrentPane({ confirm = true }))

-- tabs -------------------------------------------------------------
-- create new
append_leader_combo("t", nil, action.SpawnTab(pane_domain))
for i = 0, 7 do
  -- add `move-to` by the given index
  append_leader_combo(tostring(i + 1), nil, action.ActivateTab(i))
end
-- index 9 go to last
append_leader_combo("9", nil, action.ActivateTab(-1))
-- close tab
append_leader_combo("q", nil, action.CloseCurrentTab({ confirm = true }))

-- copy mode --------------------------------------------------------
append_leader_combo("[", nil, action.ActivateCopyMode)

-- full screen ------------------------------------------------------
append_simple_key("F11", action.ToggleFullScreen)

-- setting keymap config
M.leader = leader_key
M.keys = {}
-- push key map by using loop (avoid pushing the `push` function
-- declared at the top of the file)
for _, m in ipairs(key_maps) do
  if type(m) == "table" then
    M.keys[#M.keys + 1] = m
  end
end
return M
