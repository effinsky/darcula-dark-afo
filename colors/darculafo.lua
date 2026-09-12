-- Force a dark 'background' on first activation only. When `:set background=light`
-- re-sources an active colorscheme, flipping the option back would make Neovim discard
-- the scheme (see :help 'background'), so on re-source the colours are applied as-is.
if vim.g.colors_name ~= "darculafo" and vim.o.background ~= "dark" then
	vim.o.background = "dark"
end
require("darculafo").load()
