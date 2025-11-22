local M = {}

--- Deeply extends the `source` table into the `target` table and then,
--- returns the new `target`.
---@param target table
---@param source table
---@return table
function M.table_deep_extend(target, source)
  for k, v in pairs(source) do
    if type(v) == "table" and type(target[k]) == "table" then
      target[k] = M.deep_extend(target[k], v)
    else
      target[k] = v
    end
  end
  return target
end

return M
