local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- webdev (NvChad: format on save via format_on_save di bawah)
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    less = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    vue = { "prettier" },
    svelte = { "prettier" },
    astro = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    graphql = { "prettier" },
    markdown = { "prettier", "markdown-toc" },
    python = { "black" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    cmake = { "cmakelang" },
    sh = { "shfmt" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return options
