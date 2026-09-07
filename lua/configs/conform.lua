local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    python =  {"black"},
    C = {"clang-format"},
    cpp = {"clang-format"},
    cmake = {"cmakelang"},
    markdown = {"markdown-toc"},
    shell = {"shfmt"}
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return options
