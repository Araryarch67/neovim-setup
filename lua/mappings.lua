require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- gerak per display-line (wrap), tapi tetap support count kayak 5j
-- n = normal, v = visual+select, x = visual, o = operator-pending (dj/y j/dll)
map({ "n", "v", "x", "o" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Move down (wrap-aware)", expr = true, silent = true })
map({ "n", "v", "x", "o" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Move up (wrap-aware)", expr = true, silent = true })
map({ "n", "v", "x", "o" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Move down (wrap-aware)", expr = true, silent = true })
map({ "n", "v", "x", "o" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Move up (wrap-aware)", expr = true, silent = true })
-- insert mode: arrow tetap jalan per display-line, tetap di insert mode
map("i", "<Down>", "<C-o>gj", { desc = "Move down (wrap-aware)", silent = true })
map("i", "<Up>", "<C-o>gk", { desc = "Move up (wrap-aware)", silent = true })

map("n", "<C-t>", function()
  require("minty.shades").open({ border = false })
end, {})

vim.keymap.set("n", "<C-p>", ":FloatermToggle<CR>", { silent = true })

vim.keymap.set("n", "<C-l>", function()
  require("triforce").show_profile()
end, { desc = "tampilkan triforce statsnya" })

vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
  require('menu.utils').delete_old_menus()

  vim.cmd.exec '"normal! \\<RightMouse>"'

  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

  require("menu").open(options, { mouse = true })
end, {})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Toggle inlay hints
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

map("n", "<leader>mw", function()
  require("mywpm").open_dashboard()
end, { desc = "Open mywpm dashboard" })

map("n", "<leader>E", ":Trouble diagnostics toggle<CR>", { desc = "Toggle diagnostics (float)" })

map("n", "<leader>yd", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
  if #diagnostics == 0 then
    vim.notify("No diagnostics on this line", vim.log.levels.INFO)
    return
  end
  local lines = {}
  for _, d in ipairs(diagnostics) do
    local severity = ({ "ERROR", "WARN", "INFO", "HINT" })[d.severity] or ""
    table.insert(lines, severity .. ": " .. d.message)
  end
  vim.fn.setreg("+", table.concat(lines, "\n"))
  vim.notify("Diagnostic copied!")
end, { desc = "Copy line diagnostics to clipboard" })
