-- theme-picker active theme: 21-no-empty-icons
-- Tries colorschemes in priority order; first success wins.
local schemes = {"default", "habamax", "habamax", "default"}
for _, name in ipairs(schemes) do
  local ok = pcall(vim.cmd.colorscheme, name)
  if ok then break end
end
-- Optional: termguicolors so palette via $COLORTERM/OSC is honored
vim.opt.termguicolors = true
