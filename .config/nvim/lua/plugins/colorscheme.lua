return {
  {
    -- Plugin for the Kanagawa color scheme
    { --
      "rebelot/kanagawa.nvim",
      name = "kanagawa",
      priority = 1000,      -- High priority to ensure it loads early
      opts = {
        transparent = true, -- Enable transparent background
        theme = "dragon",   -- Set the theme variant to 'dragon'
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" }, -- Transparent background for floating windows
            FloatBorder = { bg = "none" }, -- Transparent background for floating window borders
            FloatTitle = { bg = "none" },  -- Transparent background for floating window titles

            -- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 }, -- Custom colors for dark mode
            --
            -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim }, -- Custom colors for Lazy plugin
            -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim }, -- Custom colors for Mason plugin

            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            FzfLuaNormal = { fg = theme.ui.fg_dim, bg = "none" },              -- Custom colors for FzfLua normal
            FzfLuaBorder = { fg = "none", bg = "none" },                       -- Custom colors for FzfLua border
            FzfLuaTitle = { fg = theme.ui.special, bold = true, bg = "none" }, -- Custom colors for FzfLua title

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },             -- Custom colors for popup menu
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },                   -- Custom colors for selected item in popup menu
            PmenuSbar = { bg = theme.ui.bg_m1 },                               -- Custom colors for popup menu scrollbar
            PmenuThumb = { bg = theme.ui.bg_p2 },                              -- Custom colors for popup menu thumb
          }
        end,
      },
    },

    {
      "xiyaowong/transparent.nvim",
      config = function()
        vim.defer_fn(function()
          require("transparent").setup({
            enable = true,   -- boolean: enable transparent
            extra_groups = { -- table/string: additional groups that should be cleared
              "Normal",
              "NormalNC",
              "Comment",
              "Constant",
              "Special",
              "Identifier",
              "Statement",
              "PreProc",
              "Type",
              "Underlined",
              "Todo",
              "String",
              "Function",
              "Conditional",
              "Repeat",
              "Operator",
              "Structure",
              "LineNr",
              "NonText",
              "SignColumn",
              "CursorLineNr",
              "EndOfBuffer",
            },
          })
          vim.cmd("TransparentEnable")
          vim.cmd("colorscheme kanagawa-dragon")
        end, 100) -- execute the command to enable transparency
      end,
    },

    -- {
    --   "dgox16/oldworld.nvim",
    --   lazy = false,
    --   priority = 1000,
    --   opts = {
    --     variant = "oled",
    --   },
    -- },
    {
      -- LazyVim configuration
      "LazyVim/LazyVim",
      opts = {
        -- Set the default color scheme
        colorscheme = "kanagawa-dragon",
      },
    },
  },
}
