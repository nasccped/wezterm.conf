local M = {}

--- Private function that generates a default message when panicking.
---@param obj any
---@return string
local function default_message(obj)
  return "`condition` returned true for `panic_on` function (" .. obj .. ")"
end

--- Panics the entire program over a certain condition. Note that the
--- condition isn't boolean, but a `Falsy`|`Truthy` instead. TL;DR:
--- - `false` and `nil` means false;
--- - `Any other value` means true.
---
--- The message will be printed when panicking. If no message
--- provided, a default one will be printed.
---@param condition any
---@param message? string
function M.panic_on(condition, message)
  if condition then
    error(message or default_message(condition))
  end
end

return M
