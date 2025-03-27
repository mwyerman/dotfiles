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
    if lsp_names == "" then
        return ""
    end
    return '  ' ..lsp_names
end

local function lsp_formatter_info()
    -- Check if 'conform' is available
    local status, conform = pcall(require, 'conform')
    if not status then
        return 'Conform not installed'
    end

    local lsp_format = require('conform.lsp_format')

    -- Get formatters for the current buffer
    local formatters = conform.list_formatters_for_buffer()
    if formatters and #formatters > 0 then
        local formatterNames = {}

        for _, formatter in ipairs(formatters) do
            table.insert(formatterNames, formatter)
        end

        return '󰷈 ' .. table.concat(formatterNames, ' ')
    end

    -- Check if there's an LSP formatter
    local bufnr = vim.api.nvim_get_current_buf()
    local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

    if not vim.tbl_isempty(lsp_clients) then
        return '󰷈 LSP Formatter'
    end

    return ''
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
    dependencies = { "nvim-tree/nvim-web-devicons", "arkav/lualine-lsp-progress" },
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
                lualine_c = { "lsp_progress" },
                lualine_x = {},
                lualine_y = { lsp_formatter_info, lsp_client_count, "filetype" },
                lualine_z = { "location" },
            },
            winbar = {
                lualine_b = { {"filename", path = 1} }
            },
            inactive_winbar = {
                lualine_c = { {"filename", path = 1} }
            },
            tabline = {
                lualine_a = { buffer_count },
                lualine_b = { require("lualine_marks") },
                lualine_z = { "tabs" },
            },
        })
    end
}
