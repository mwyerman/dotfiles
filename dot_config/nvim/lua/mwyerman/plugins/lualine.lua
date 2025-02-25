function shorten_path(filepath)
    -- Handle Windows paths by replacing '\' with '/'
    filepath = filepath:gsub("\\", "/")

    -- Split the filepath into components
    local components = {}
    for component in filepath:gmatch("[^/]+") do
        table.insert(components, component)
    end

    -- Reduce each component to the first letter
    for i, component in ipairs(components) do
        if i == #components then
            components[i] = component
        else
            if component:sub(1, 1) == '.' then
                -- For dotfiles, keep a second letter
                components[i] = component:sub(1, 2)
            else
                components[i] = component:sub(1, 1)
            end
        end
    end

    -- Rejoin the components back into a shortened path
    return table.concat(components, "/")
end

local function lsp_client_count()
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = buf })
    local lsp_names = ""
    for i, v in ipairs(clients) do
        if i == 1 then
            lsp_names = lsp_names .. v.name
        else
            lsp_names = lsp_names .. " + " .. v.name
        end
    end
    return lsp_names
end

local function buffer_count()
    local buffers = vim.api.nvim_list_bufs()
    local count = 0
    local modified_count = 0
    for _, bufnr in ipairs(buffers) do
        local readonly = vim.api.nvim_get_option_value("readonly", { buf = bufnr })
        if readonly then
            goto continue
        end

        local listed = vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
        if not listed then
            goto continue
        end

        local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
        if buftype == "terminal" then
            goto continue
        end
        if buftype == "quickfix" then
            goto continue
        end

        count = count + 1

        local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
        if modified then
            modified_count = modified_count + 1
        end

        ::continue::
    end


    return tostring(count) .. " [" .. tostring(modified_count) .. "]"
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                disabled_filetypes = {
                    statusline = {
                        "alpha",
                    },
                },
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                    },
                },
                lualine_x = { lsp_client_count },
                lualine_y = { "filetype" },
                lualine_z = { "location" },
            },
            tabline = {
                lualine_a = { buffer_count },
                lualine_b = { require("lualine_marks") },
                lualine_z = { "tabs" },
            },
        })
    end
}
