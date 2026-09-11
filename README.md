# nvim dotfiles (NvChad v2.5 based)

<img width="447" height="447" alt="images" src="https://github.com/user-attachments/assets/827b0bd6-558a-4971-86c7-1b1fa56e9a00" />

Basis: [NvChad v2.5](https://github.com/NvChad/NvChad/tree/v2.5) via `lazy.nvim`.
Config custom ada di `lua/plugins/init.lua`, `lua/configs/`, `lua/mappings.lua`, `lua/options.lua`, `lua/chadrc.lua`.

## Plugin bawaan NvChad (via `import = "nvchad.plugins"`)

| Plugin | Fungsi |
| --- | --- |
| `nvchad/base46` + `nvchad/ui` | tema (`everblush`, transparent), statusline, tabufline, dashboard |
| `nvim-lua/plenary.nvim` | dependency (telescope, dll) |
| `nvzone/volt` + `nvzone/menu` | backend + menu klik-kanan |
| `nvim-tree/nvim-web-devicons` | ikon file |
| `nvim-tree/nvim-tree.lua` | file explorer |
| `folke/which-key.nvim` | popup keymap |
| `lewis6991/gitsigns.nvim` | git gutter |
| `mason-org/mason.nvim` | installer LSP / formatter |
| `windwp/nvim-autopairs` | auto tutup kurung |
| `hrsh7th/nvim-cmp` + `cmp-nvim-lsp`, `cmp-buffer`, `cmp-nvim-lua`, `cmp_luasnip`, `L3MON4D3/LuaSnip`, `rafamadriz/friendly-snippets` | completion |
| `nvim-telescope/telescope.nvim` | fuzzy finder (tergantung treesitter) |
| `lukas-reineke/indent-blankline.nvim` | indent guide |

## Plugin tambahan (di `lua/plugins/init.lua`)

| Plugin | Fungsi / catatan |
| --- | --- |
| `stevearc/conform.nvim` | formatter + **format on save** (lihat `lua/configs/conform.lua`) |
| `neovim/nvim-lspconfig` | LSP, daftar server di `lua/configs/lspconfig.lua` |
| `nvim-treesitter/nvim-treesitter` (`:TSUpdate`) | syntax highlight / indent webdev, `ensure_installed` di `plugins/init.lua` |
| `hrsh7th/nvim-cmp` (override) + `hrsh7th/cmp-cmdline` | navigasi completion pakai `<Up>`/`<Down>`, completion untuk `:` dan `/` |
| `wakatime/vim-wakatime` | tracking waktu coding |
| `lukas-reineke/indent-blankline.nvim` | **disabled** (`enabled = false`) |
| `IogaMaster/neocord` | Discord rich presence (`configs/discord.lua`) |
| `nvchad/minty` | color picker (`<C-t>`) |
| `nvchad/showkeys` | tampilkan key yang ditekan (`:ShowkeysToggle`) |
| `nvzone/typr` | typing test (`:Typr`, `:TyprStats`) |
| `shellRaining/hlchunk.nvim` | indent + chunk highlight (`configs/chunk.lua`) |
| `nvzone/timerly` | timer (`:TimerlyToggle`) |
| `nvzone/floaterm` | terminal floating (`<C-p>`) |
| `Civitasv/cmake-tools.nvim` | CMake workflow |
| `slowy07/mywpm.nvim` | WPM dashboard (`<leader>mw`) |
| `gisketch/triforce.nvim` | profiling (`<C-l>`) |
| `folke/todo-comments.nvim` | highlight TODO/FIXME |
| `folke/trouble.nvim` | diagnostics float (`<leader>E`) |
| `OXY2DEV/markview.nvim` | preview markdown |
| `richwomanbtc/overleaf.nvim` | sync Overleaf (butuh `cookie`, saat ini hardcoded di `plugins/init.lua` — sebaiknya pindah ke env/var) |

## LSP (`lua/configs/lspconfig.lua`)

`html`, `cssls`, `ts_ls` (JS/TS), `lua_ls`, `clangd`, `basedpyright` (Python),
`gopls`, `rust_analyzer`, `neocmake`, `zls`, `docker_language_server`,
`powershell_es`, `bashls`, `nim_langserver`.

Inlay hint nyala by default (`vim.lsp.inlay_hint.enable(true)`), toggle: `<leader>ih`.

## Formatter / format on save (`lua/configs/conform.lua`)

`format_on_save = { timeout_ms = 500, lsp_format = "fallback" }` — plugin dimuat
saat startup supaya aktif untuk semua file.

| Filetype | Formatter |
| --- | --- |
| `html`, `css`, `scss`, `less` | `prettier` |
| `javascript`, `javascriptreact`, `typescript`, `typescriptreact`, `vue`, `svelte`, `astro` | `prettier` |
| `json`, `jsonc`, `yaml`, `graphql` | `prettier` |
| `markdown` | `prettier`, `markdown-toc` |
| `lua` | `stylua` |
| `python` | `black` |
| `c`, `cpp` | `clang-format` |
| `cmake` | `cmakelang` |
| `sh` | `shfmt` |

Butuh binary-nya (via Mason / npm), misal `:MasonInstall prettier stylua black clang-format shfmt`.

## Tree-sitter webdev (`plugins/init.lua`)

`ensure_installed`:

`vim`, `lua`, `vimdoc`, `html`, `css`, `scss`, `javascript`, `typescript`,
`tsx`, `json`, `jsonc`, `jsdoc`, `regex`, `vue`, `svelte`, `astro`,
`graphql`, `yaml`, `toml`, `markdown`, `markdown_inline`, `bash`.

Install/update: `:TSUpdate`, `:TSInstall <lang>`, `:TSInstallAll`.

## Keymap custom penting (`lua/mappings.lua`)

- `j`/`k`/`<Up>`/`<Down>` wrap-aware (`gj`/`gk`) untuk mode normal, visual, select, operator-pending; di insert mode `<Up>`/`<Down>` pakai `<C-o>gk`/`<C-o>gj`
- `;` → `:`, `jk` → `<ESC>` (insert)
- `<C-t>` minty shades, `<C-p>` floaterm, `<C-l>` triforce
- klik-kanan → nvzone menu
- `<leader>ih` toggle inlay hint, `<leader>mw>` mywpm dashboard, `<leader>E` trouble diagnostics, `<leader>yd` copy diagnostics baris ini
