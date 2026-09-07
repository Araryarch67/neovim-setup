-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

vim.diagnostic.config({ virtual_text = false })

M.base46 = {
  theme = "everblush",
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}


M.nvdash = {
  load_on_startup = true,
  header = {
    "",
    "vscode killers, and jetbrains slayer",
    "",
    -- "           ▄ ▄                   ",
    -- "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
    -- "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
    -- "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
    -- "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
    -- "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
    -- "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
    -- "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
    -- "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
  },
}
M.ui = {
  telescope = {
    style = "borderless"
  },
  tabufline = {
    enabled = false,
  },
  statusline = {
    theme = "minimal",
    separator_style = "default",
  },
  cmp = {
    style = "atom_colored"
  },
}

return M
