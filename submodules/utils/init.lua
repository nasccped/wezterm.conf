local tbl = require("submodules/utils/table")
local panic = require("submodules/utils/panic")
local M = {}

-- Add the function manually (allow lsp docs).

-- panic ------------------------------------------------------------
M.panic_on = panic.panic_on

-- table ------------------------------------------------------------
M.table_deep_extend = tbl.table_deep_extend

return M
