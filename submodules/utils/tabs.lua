local M = {}

--- Gets the title based on `TabInformation` value. If no title for
--- the given tab, it's `active_pane` title will be returned.
---@param tab_info any
---@return string
function M.tab_get_title(tab_info)
  local title = tab_info.tab_title
  local default = tab_info.active_pane.title
  return title and #title > 0 and title or default
end

return M
