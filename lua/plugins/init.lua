return {
  {
    "stevearc/conform.nvim",
    -- dimuat saat startup supaya format_on_save (configs/conform.lua) aktif untuk webdev
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },

  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    enabled = false,
  },

  {
    "IogaMaster/neocord",
    event = "VeryLazy",
    config = function()
      require "configs.discord"
    end,
  },
  {
    "nvchad/minty",
    lazy = true,
    config = function()
      require "configs.minty"
    end,
  },

  { "nvchad/showkeys", cmd = "ShowkeysToggle", opts = { position = "top-center" } },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.chunk"
    end
  },

  { "nvzone/volt",     lazy = true },
  { "nvzone/menu",     lazy = true },

  {
    "nvzone/timerly",
    dependencies = 'nvzone/volt',
    cmd = "TimerlyToggle",
    opts = {} -- optional
  },

  {
    "nvzone/floaterm",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = "FloatermToggle",
  },

  { 'Civitasv/cmake-tools.nvim', opts = {} },

  {
    "slowy07/mywpm.nvim",
    dependencies = "nvzone/volt",
    event = "VeryLazy",
    config = function()
      require "configs.mywpm"
    end
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- override nvim-cmp: navigasi arrow + completion command mode
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-cmdline",
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      -- pilih item pakai arrow atas/bawah (insert mode), langsung isi text
      opts.mapping["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }
      opts.mapping["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }
      return opts
    end,
    config = function(_, opts)
      local cmp = require "cmp"
      cmp.setup(opts)

      -- mapping cmdline: arrow atas/bawah + Tab langsung autocomplete
      local cmdline_mapping = cmp.mapping.preset.cmdline {
        ["<Down>"] = {
          c = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        },
        ["<Up>"] = {
          c = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        },
      }

      -- autocompletion saat `:` (command mode)
      cmp.setup.cmdline(":", {
        mapping = cmdline_mapping,
        sources = cmp.config.sources(
          { { name = "async_path" } },
          { { name = "cmdline" } }
        ),
        matching = { disallow_symbol_nonprefix_matching = false },
      })

      -- autocompletion saat `/` dan `?` (search)
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmdline_mapping,
        sources = { { name = "buffer" } },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        -- webdev
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "jsonc",
        "jsdoc",
        "regex",
        "vue",
        "svelte",
        "astro",
        "graphql",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "bash",
      },
    },
  },

  {
    "gisketch/triforce.nvim",
    dependencies = {
      "nvzone/volt",
    },
    config = function()
      require "configs.triforce"
    end,
  },

  -- todo nvim
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require "configs.todo"
    end
  },

  -- trouble nvim
  {
    "folke/trouble.nvim",
    lazy = false,
    opts = {
      modes = {
        diagnostics = {
          win = { target = "float", width = 0.7, height = 0.6 },
        },
        lsp_document_symbols = {
          win = { target = "float", width = 0.7, height = 0.6 },
        },
      },
    },
    cmd = "Trouble",
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
},

{
  'richwomanbtc/overleaf.nvim',
lazy = false,
  config = function()
    require('overleaf').setup({
      cookie = 's%3A752DdyZE89sWKTeSg267rCa6kX9pPoxE.pIYlmst60FSjHwqCVNnRo7qxpFlTmnD3jFU6dgBLYh8',
    })
  end,
  build = 'cd node && npm install',
}

}
