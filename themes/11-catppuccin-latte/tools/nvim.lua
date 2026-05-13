-- theme-picker active theme: 11-catppuccin-latte
-- Tries colorschemes in priority order; first success wins.
local schemes = {"catppuccin-latte", "catppuccin", "habamax", "default"}
for _, name in ipairs(schemes) do
  local ok = pcall(vim.cmd.colorscheme, name)
  if ok then break end
end
-- Optional: termguicolors so palette via $COLORTERM/OSC is honored
vim.opt.termguicolors = true
