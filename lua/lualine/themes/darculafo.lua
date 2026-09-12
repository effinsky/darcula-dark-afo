-- lualine picks this up automatically when `options.theme = "auto"` and
-- vim.g.colors_name == "darculafo".
local p = require "darculafo.palette"

local function accent(bg) return { fg = p.ui_fg, bg = bg, gui = "bold" } end
local b = { fg = p.ui_fg, bg = p.panel }
local c = { fg = p.ui_info, bg = p.panel }
local inactive = { fg = p.ui_dim, bg = p.panel }

return {
	normal = { a = accent(p.sel), b = b, c = c },
	insert = { a = accent(p.diff_add), b = b, c = c },
	visual = { a = accent(p.diff_mod), b = b, c = c },
	replace = { a = accent(p.diff_conflict), b = b, c = c },
	command = { a = accent(p.warn_bg), b = b, c = c },
	terminal = { a = accent(p.brace_bg), b = b, c = c },
	inactive = { a = inactive, b = inactive, c = inactive },
}
