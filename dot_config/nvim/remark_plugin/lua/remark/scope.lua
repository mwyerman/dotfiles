--- @alias Scope "file" | "cwd" | "global"

local S = {}

--- Get a scope path from the current scope
--- @param scope Scope
--- @return string
function S.resolve_path(scope)
    if scope == "file" then
        return vim.api.nvim_buf_get_name(0)
    elseif scope == "cwd" then
        return vim.fn.getcwd()
    elseif scope == "global" then
        return ""
    else
        error("Invalid scope")
    end
end

return S
