-- Run with `make test`:
--   nvim --clean --headless --cmd "set rtp^=<repo>" -l tests/check.lua
-- Asserts that key groups resolve to the Darcula values, that dead groups are gone,
-- that every capture nvim-treesitter's Go query emits is covered by the theme, and
-- that no link points at a group the theme does not define.

local ok_cs, err = pcall(vim.cmd.colorscheme, "darculafo")
if not ok_cs then
	io.stderr:write("colorscheme darculafo failed: " .. tostring(err) .. "\n")
	os.exit(1)
end

local p = require "darculafo.palette"
local fails, checks = 0, 0

local function fail(msg)
	fails = fails + 1
	io.stderr:write("FAIL " .. msg .. "\n")
end

local function hex(v) return v and string.format("#%06x", v) or nil end

local function resolved(name)
	local h = vim.api.nvim_get_hl(0, { name = name, link = false })
	return {
		fg = hex(h.fg),
		bg = hex(h.bg),
		sp = hex(h.sp),
		bold = h.bold or nil,
		italic = h.italic or nil,
		underline = h.underline or nil,
		undercurl = h.undercurl or nil,
		underdotted = h.underdotted or nil,
		strikethrough = h.strikethrough or nil,
	}
end

--- want[k] == false asserts that the attribute is absent.
local function expect(name, want)
	if next(want) == nil then
		fail(name .. ": empty expectation (missing palette key?)")
		return
	end
	local got = resolved(name)
	for k, v in pairs(want) do
		checks = checks + 1
		local pass = (v == false and got[k] == nil) or got[k] == v
		if not pass then
			fail(
				("%s.%s: want %s, got %s"):format(
					name,
					k,
					tostring(v),
					tostring(got[k])
				)
			)
		end
	end
end

-- editor chrome -------------------------------------------------------------------------
expect("Normal", { fg = p.fg, bg = p.bg })
expect("CursorLine", { bg = p.caret_row })
expect("Visual", { bg = p.sel })
expect("LineNr", { fg = p.line_nr, bg = p.gutter })
expect("CursorLineNr", { fg = p.line_nr_cur, bold = false })
expect("SignColumn", { bg = p.gutter })
expect("Search", { bg = p.search })
expect("CurSearch", { bg = p.sel })
expect("IncSearch", { bg = p.sel })
expect("MatchParen", { fg = p.brace_fg, bg = p.brace_bg, bold = true })
expect("Folded", { fg = p.fold_fg, bg = p.fold_bg })
expect("NonText", { fg = p.whitespace, bold = false })
expect("Pmenu", { fg = p.ui_fg, bg = p.popup })
expect("PmenuSel", { bg = p.completion_sel })
expect("NormalFloat", { bg = p.popup })
expect("FloatBorder", { fg = p.tearline })
expect("StatusLine", { fg = p.ui_fg, bg = p.panel })
expect("TabLine", { fg = p.ui_fg, bg = p.panel })
expect("TabLineSel", { bg = p.bg })
expect("Cursor", { bg = p.caret })
expect("Identifier", { fg = p.fg })
expect("Todo", { fg = p.todo, italic = true, bg = false })

-- diff / diagnostics / lsp ui ------------------------------------------------------------
expect("DiffAdd", { bg = p.diff_add })
expect("DiffDelete", { bg = p.diff_del })
expect("DiffChange", { bg = p.diff_mod })
expect("DiffText", { bg = p.diff_mod_stripe })
expect("DiagnosticError", { fg = p.error_text })
expect("DiagnosticUnderlineError", { sp = p.error, undercurl = true })
expect(
	"DiagnosticUnderlineWarn",
	{ bg = p.warn_bg, undercurl = false, underline = false }
)
expect("DiagnosticUnnecessary", { fg = p.unused, italic = false })
expect("DiagnosticDeprecated", { sp = p.deprecated, strikethrough = true })
expect("LspReferenceRead", { bg = p.ref_read })
expect("LspReferenceWrite", { bg = p.ref_write })
expect("LspInlayHint", { fg = p.inlay_fg, bg = p.inlay_bg })
expect("SpellBad", { sp = p.typo, undercurl = true })

-- syntax -----------------------------------------------------------------------------------
expect("@comment", { fg = p.comment, italic = false })
expect("@comment.documentation", { fg = p.doc_comment })
expect("@comment.documentation.go", { fg = p.comment })
expect("@keyword", { fg = p.keyword })
expect("@keyword.import", { fg = p.keyword })
expect("@keyword.conditional", { fg = p.keyword })
expect("@keyword.repeat", { fg = p.keyword })
expect("@string", { fg = p.string })
expect("@string.escape", { fg = p.escape })
expect("@character", { fg = p.string })
expect("@number", { fg = p.number })
expect("@number.float", { fg = p.number })
expect("@boolean", { fg = p.keyword })
expect("@constant", { fg = p.constant, italic = true })
expect("@constant.builtin", { fg = p.keyword })
expect("@module", { fg = p.package_go })
expect("@label", { fg = p.fg, bold = true, underline = true })
expect("@type", { fg = p.type_ref_go })
expect("@type.builtin", { fg = p.builtin_go })
expect("@type.definition", { fg = p.fg })
expect("@function", { fg = p.func_decl })
expect("@function.method", { fg = p.func_decl })
expect("@function.builtin", { fg = p.keyword })
expect("@function.call", { fg = p.fg })
expect("@function.call.go", { fg = p.func_call_go })
expect("@function.method.call.go", { fg = p.func_call_go })
expect("@constructor.go", { fg = p.func_call_go })
expect("@variable", { fg = p.fg })
expect("@variable.member", { fg = p.fg })
expect("@variable.parameter", { fg = p.fg })
expect("@variable.parameter.receiver", { fg = p.receiver_go })
expect("@property.json", { fg = p.constant })
expect("@property.yaml", { fg = p.keyword })
expect("@punctuation.delimiter", { fg = p.fg })
expect("@punctuation.delimiter.comma", { fg = p.keyword })
expect("@attribute", { fg = p.metadata })
expect("@markup.heading", { fg = p.ui_fg, bg = p.md_header_bg, bold = true })
expect("@markup.strikethrough", { strikethrough = true, fg = false })
expect("@markup.link.url", { fg = p.link, underline = true })
expect("@tag", { fg = p.html_tag })

-- gopls semantic tokens ----------------------------------------------------------------------
expect("@lsp.type.namespace", { fg = p.package_go })
expect("@lsp.type.type", { fg = p.type_ref_go })
expect("@lsp.type.function.go", { fg = p.func_call_go })
expect("@lsp.type.method.go", { fg = p.func_call_go })
expect("@lsp.typemod.function.definition.go", { fg = p.func_decl })
expect("@lsp.typemod.function.defaultLibrary.go", { fg = p.builtin_go })
expect("@lsp.typemod.type.defaultLibrary.go", { fg = p.builtin_go })
expect("@lsp.mod.readonly.go", { fg = p.constant, italic = true })
expect("@lsp.typemod.variable.defaultLibrary.go", { fg = p.builtin_go })
expect("@lsp.typemod.string.format.go", { fg = p.escape })
for _, t in ipairs {
	"variable",
	"parameter",
	"property",
	"function",
	"method",
	"string",
	"comment",
} do
	expect("@lsp.type." .. t, { fg = false, bg = false })
end

-- readonly must stay at mod priority (126) so defaultLibrary (typemod, 127) wins for nil/true/false
expect("@lsp.typemod.variable.readonly", { fg = false, bg = false, italic = false })
expect("@lsp.typemod.variable.readonly.go", { fg = false, bg = false, italic = false })

-- extras are off by default and flip only what they name -----------------------------------
expect("@variable.member", { fg = p.fg })
require("darculafo").setup {
	extras = {
		purple_fields = true,
		purple_builtin_constants = true,
		purple_labels = true,
	},
}
expect("@variable.member", { fg = p.constant, italic = false })
expect("@property", { fg = p.constant })
expect("@property.yaml", { fg = p.keyword })
expect("@function.method.call.go", { fg = p.func_call_go })
expect("@boolean", { fg = p.constant })
expect("@constant.builtin", { fg = p.constant })
expect("@lsp.typemod.variable.defaultLibrary.go", { fg = p.constant })
expect("@label", { fg = p.constant, bold = true, underline = true })
expect("BlinkCmpKindField", { fg = p.constant })
require("darculafo").setup {}
expect("@variable.member", { fg = p.fg })
expect("@boolean", { fg = p.keyword })

-- terminal -----------------------------------------------------------------------------------
checks = checks + 1
if vim.g.terminal_color_1 ~= p.ansi.red or vim.g.terminal_color_4 ~= p.ansi.blue then
	fail "terminal colours not applied"
end

-- groups that must be gone -----------------------------------------------------------------------
for _, name in ipairs {
	"BufferDefaultCurrent",
	"NERDTreeFile",
	"SniprunFloatingWinOk",
	"HopNextKey",
	"EyelinerPrimary",
	"DefinitionArrow",
	"FinderParam",
	"SagaShadow",
	"ScrollbarHandle",
	"NotifyERRORBorder",
	"rainbowcol1",
	"IndentBlanklineChar",
	"SymbolsOutlineConnector",
	"User1",
	"ConflictMarkerBegin",
	"lualine_a_normal",
	"TSKeyword",
	"TSComment",
	"TSStrike",
} do
	checks = checks + 1
	if vim.fn.hlexists(name) == 1 then fail("stale group still defined: " .. name) end
end

-- every capture nvim-treesitter's Go query emits must be covered by the theme itself ----------
local groups = require("darculafo").groups()
local go_captures = {
	"@boolean",
	"@character",
	"@comment",
	"@comment.documentation",
	"@constant",
	"@constant.builtin",
	"@constructor",
	"@function",
	"@function.builtin",
	"@function.call",
	"@function.method",
	"@function.method.call",
	"@keyword",
	"@keyword.conditional",
	"@keyword.coroutine",
	"@keyword.function",
	"@keyword.import",
	"@keyword.repeat",
	"@keyword.return",
	"@keyword.type",
	"@label",
	"@module",
	"@number",
	"@number.float",
	"@operator",
	"@property",
	"@punctuation.bracket",
	"@punctuation.delimiter",
	"@string",
	"@string.escape",
	"@string.regexp",
	"@type",
	"@type.builtin",
	"@type.definition",
	"@variable",
	"@variable.member",
	"@variable.parameter",
}
for _, cap in ipairs(go_captures) do
	checks = checks + 1
	local name, found = cap, false
	while name do
		if groups[name] then
			found = true
			break
		end
		name = name:match "^(.*)%.[^.]+$"
	end
	if not found then fail("Go capture not covered by theme: " .. cap) end
end

-- links must target groups the theme defines, or they silently pick up Neovim defaults ---------
for name, def in pairs(groups) do
	if def.link then
		checks = checks + 1
		if not groups[def.link] then
			fail(("%s links to undefined group %s"):format(name, def.link))
		end
	end
end

if fails > 0 then
	io.stderr:write(("%d of %d checks failed\n"):format(fails, checks))
	os.exit(1)
end
print(("darculafo: %d checks passed"):format(checks))
