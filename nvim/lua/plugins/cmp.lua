return {
  "hrsh7th/nvim-cmp",                      -- base plugin
  dependencies = {
    "hrsh7th/cmp-buffer",                  -- buffer completions
    "hrsh7th/cmp-path",                    -- path completions
    "hrsh7th/cmp-cmdline",                 -- cmdline completions
    "hrsh7th/cmp-nvim-lsp",                -- lsp
    "hrsh7th/cmp-nvim-lsp-signature-help", -- lsp signatures
    "hrsh7th/cmp-nvim-lua",                -- nvim source

    "saadparwaiz1/cmp_luasnip",            -- snipped completions
    "L3MON4D3/LuaSnip",                    -- snippet engine
    "rafamadriz/friendly-snippets",        -- additional snippets
  },
  event = "InsertEnter",
  cond = not vim.g.vscode,
  config = function()
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
      return
    end

    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then
      return
    end

    require("luasnip/loaders/from_vscode").lazy_load()

    local check_backspace = function()
      local col = vim.fn.col "." - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
    end

    --   פּ ﯟ   some other good icons
    local kind_icons = {
      Text = "",
      Method = "m",
      Function = "",
      Constructor = "",
      Field = "",
      Variable = "",
      Class = "",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    }
    -- find more here: https://www.nerdfonts.com/cheat-sheet

    cmp.setup {
      window = {
        completion = {
          -- side_padding = 1,
          max_width = 20
          -- winhighlight = "Normal:CmpItemMenu"
        },
        documentation = {
          side_padding = 1,
          winhighlight = "Normal:CmpDoc"
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      },
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(_, item)
          local icon = " " .. kind_icons[item.kind] .. " "
          item.kind = icon .. item.kind

          local MAX_LABEL_WIDTH = 30
          local MIN_LABEL_WIDTH = 20
          local ELLIPSIS_CHAR = "…"

          local label = item.abbr
          local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
          if truncated_label ~= label then
            item.abbr = truncated_label .. ELLIPSIS_CHAR
          elseif string.len(label) < MIN_LABEL_WIDTH then
            local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
            item.abbr = label .. padding
          end

          return item
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
        { name = "nvim_lsp_signature_help" },
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      experimental = {
        ghost_text = false,
      },
    }
  end
}
