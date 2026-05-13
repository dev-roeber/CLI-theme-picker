-- theme-picker active theme: 74-tomorrow-night
-- Tries colorschemes in priority order; first success wins.
local schemes = {"tomorrow-night", "tomorrow", "habamax", "default"}
for _, name in ipairs(schemes) do
  local ok = pcall(vim.cmd.colorscheme, name)
  if ok then break end
end
-- Optional: termguicolors so palette via $COLORTERM/OSC is honored
vim.opt.termguicolors = true
