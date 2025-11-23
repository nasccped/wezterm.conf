local M = {}
local wz = require("wezterm")
local action = wz.action
local panic_on = require("submodules/utils/panic").panic_on
local default_split_param = { domain = "CurrentPaneDomain" }
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

--- Push a new key map into the `key_maps` table which operates with
--- the `LEADER` key. You can optionally pass another mod key
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
  key_maps[#key_maps + 1] = {
    key = key,
    mods = other_mod and other_mod .. "|LEADER" or "LEADER",
    action = act,
  }
end

--- pushing leader + key into key maps ------------------------------
append_leader_combo("/", nil, action.SplitHorizontal(default_split_param))
append_leader_combo("?", nil, action.SplitVertical(default_split_param))
append_leader_combo("[", nil, action.ActivateCopyMode)

M.leader = leader_key
M.keys = key_maps
return M
