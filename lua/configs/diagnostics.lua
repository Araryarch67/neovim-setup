local M = {}

local severity_icons = {
  [vim.diagnostic.severity.ERROR] = "\u{f057}",
  [vim.diagnostic.severity.WARN] = "\u{f071}",
  [vim.diagnostic.severity.INFO] = "\u{f05a}",
  [vim.diagnostic.severity.HINT] = "\u{f0eb}",
}

local severity_names = {
  [vim.diagnostic.severity.ERROR] = "ERROR",
  [vim.diagnostic.severity.WARN] = "WARN",
  [vim.diagnostic.severity.INFO] = "INFO",
  [vim.diagnostic.severity.HINT] = "HINT",
}

function M.show()
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)

  if #diagnostics == 0 then
    vim.notify("No diagnostics!", vim.log.levels.INFO)
    return
  end

  table.sort(diagnostics, function(a, b)
    if a.severity ~= b.severity then
      return a.severity < b.severity
    end
    return a.lnum < b.lnum
  end)

  local lines = {}
  local diags_by_line = {}

  for i, d in ipairs(diagnostics) do
    local icon = severity_icons[d.severity] or "?"
    local severity = severity_names[d.severity] or "UNKNOWN"
    local lnum = d.lnum + 1
    local col = d.col + 1
    local msg = d.message:gsub("\n", " "):sub(1, 120)

    lines[i] = string.format(" %s %s [L%d C%d] %s", icon, severity, lnum, col, msg)
    diags_by_line[i] = d
  end

  local float_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(float_buf, "modifiable", false)
  vim.api.nvim_buf_set_option(float_buf, "buftype", "nofile")

  local width = 0
  for _, l in ipairs(lines) do
    width = math.max(width, #l)
  end
  width = math.min(width + 4, vim.o.columns - 4)
  local height = math.min(#lines, vim.o.lines - 5)

  local win = vim.api.nvim_open_win(float_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = string.format(" Diagnostics (%d) ", #diagnostics),
    title_pos = "center",
  })

  vim.api.nvim_win_set_option(win, "cursorline", true)

  local hl_map = {
    [vim.diagnostic.severity.ERROR] = "DiagnosticError",
    [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
    [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
    [vim.diagnostic.severity.HINT] = "DiagnosticHint",
  }

  for i, d in ipairs(diagnostics) do
    local match = lines[i]:find("%[L%d")
    if match then
      vim.api.nvim_buf_add_highlight(float_buf, -1, hl_map[d.severity], i - 1, 0, match - 1)
    end
  end

  vim.keymap.set("n", "<CR>", function()
    local cursor = vim.api.nvim_win_get_cursor(win)
    local idx = cursor[1]
    local d = diags_by_line[idx]
    if not d then
      return
    end
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_set_current_buf(bufnr)
    vim.api.nvim_win_set_cursor(0, { d.lnum + 1, math.max(d.col, 0) })
    vim.cmd("normal! zz")
  end, { buffer = float_buf, nowait = true })

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = float_buf, nowait = true })

  vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
    once = true,
  })
end

return M