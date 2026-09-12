local M = {}

local defaults = {
	-- When false every @lsp.* group is made transparent, so semantic tokens add no
	-- colour and treesitter decides everything.
	semantic_tokens = true,
	integrations = {
		blink = true,
		nvim_cmp = true, -- CmpItem* aliases (used by blink when use_nvim_cmp_as_default is on)
		gitsigns = true,
		mini = true,
		ibl = true,
		treesitter_context = true,
		oil = true,
		grug_far = true,
		dap = true,
		copilot = true,
		telescope = true,
		mason = true,
	},
}

M.config = vim.deepcopy(defaults)

-- Accept the historical `setup { opt = { integrations = {...} } }` shape and the
-- old flag names so existing configs keep working.
local function normalize(opts)
	opts = vim.deepcopy(opts or {})
	if type(opts.opt) == "table" then
		opts = vim.tbl_deep_extend("force", opts, opts.opt)
		opts.opt = nil
	end
	local i = opts.integrations
	if type(i) == "table" then
		if i.lsp_semantics_token ~= nil then
			opts.semantic_tokens = i.lsp_semantics_token
			i.lsp_semantics_token = nil
		end
		if i.dap_nvim ~= nil then
			i.dap = i.dap_nvim
			i.dap_nvim = nil
		end
		-- lualine finds lua/lualine/themes/darculafo.lua on its own
		i.lualine = nil
	end
	return opts
end

---@param opts table|nil
function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), normalize(opts))
	-- go through :colorscheme so ColorScheme autocommands (lualine, blink, mini, gitsigns) fire
	vim.cmd.colorscheme "darculafo"
end

--- Full highlight table for the current config. Used by load() and by tests.
---@return table<string, vim.api.keyset.highlight>
function M.groups()
	local p = require "darculafo.palette"
	local groups = {}
	for _, mod in ipairs { "editor", "syntax", "plugins" } do
		for name, def in pairs(require("darculafo.groups." .. mod)(p, M.config)) do
			groups[name] = def
		end
	end
	return groups
end

--- Apply the theme. Called by colors/darculafo.lua; idempotent.
function M.load()
	vim.cmd "highlight clear"
	vim.g.colors_name = "darculafo"
	vim.o.termguicolors = true

	local set = vim.api.nvim_set_hl
	for name, def in pairs(M.groups()) do
		set(0, name, def)
	end

	local p = require "darculafo.palette"
	local a = p.ansi
	local term = {
		p.bg, -- ANSI black would vanish on the Darcula canvas
		a.red,
		a.green,
		a.yellow,
		a.blue,
		a.magenta,
		a.cyan,
		a.white,
		a.bright_black,
		a.bright_red,
		a.bright_green,
		a.bright_yellow,
		a.bright_blue,
		a.bright_magenta,
		a.bright_cyan,
		a.bright_white,
	}
	for idx, color in ipairs(term) do
		vim.g["terminal_color_" .. (idx - 1)] = color
	end
end

return M
