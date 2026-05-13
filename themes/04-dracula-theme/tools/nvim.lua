-- theme-picker active theme: 04-dracula-theme
-- Tries colorschemes in priority order; first success wins.
local schemes = {"dracula", "habamax", "default"}
for _, name in ipairs(schemes) do
  local ok = pcall(vim.cmd.colorscheme, name)
  if ok then break end
end
-- Optional: termguicolors so palette via $COLORTERM/OSC is honored
vim.opt.termguicolors = true
