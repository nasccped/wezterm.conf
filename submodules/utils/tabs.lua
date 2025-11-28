local M = {}

--- Gets the title based on `TabInformation` value. If no title for
--- the given tab, the default title (`"tab <TAB_INDEX + 1>"`) is
--- returned.
---@param tab_info any
---@return string
function M.tab_get_title(tab_info)
  local title = tab_info.tab_title
  local ind = tab_info.tab_index + 1
  return type(title) == "string" and #title > 0
      and string.format("%d: %s", ind, title)
      or string.format("tab %d", ind)
end

return M
