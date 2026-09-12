-- Editor chrome, messages, diff, spell, diagnostics, LSP UI, debugger.
---@param p table palette
---@return table<string, vim.api.keyset.highlight>
return function(p)
	local g = {
		-- canvas ---------------------------------------------------------------------
		Normal = { fg = p.fg, bg = p.bg },
		NormalNC = { fg = p.fg, bg = p.bg },
		NormalFloat = { fg = p.ui_fg, bg = p.popup },
		FloatBorder = { fg = p.tearline, bg = p.popup },
		FloatTitle = { fg = p.ui_fg, bg = p.popup, bold = true },
		FloatFooter = { fg = p.ui_dim, bg = p.popup },
		WinSeparator = { fg = p.panel },
		VertSplit = { link = "WinSeparator" },
		EndOfBuffer = { fg = p.bg },
		NonText = { fg = p.whitespace },
		Whitespace = { fg = p.whitespace },
		SpecialKey = { fg = p.whitespace },
		Conceal = { fg = p.whitespace },
		Ignore = { fg = p.bg },

		-- cursor / current line ------------------------------------------------------
		Cursor = { fg = p.bg, bg = p.caret },
		lCursor = { link = "Cursor" },
		CursorIM = { link = "Cursor" },
		TermCursor = { link = "Cursor" },
		TermCursorNC = { fg = p.bg, bg = p.ui_dim },
		CursorLine = { bg = p.caret_row },
		CursorColumn = { bg = p.caret_row },
		ColorColumn = { bg = p.caret_row },

		-- gutter -----------------------------------------------------------------------
		LineNr = { fg = p.line_nr, bg = p.gutter },
		LineNrAbove = { link = "LineNr" },
		LineNrBelow = { link = "LineNr" },
		CursorLineNr = { fg = p.line_nr_cur, bg = p.gutter },
		SignColumn = { fg = p.line_nr, bg = p.gutter },
		CursorLineSign = { link = "SignColumn" },
		FoldColumn = { fg = p.line_nr, bg = p.gutter },
		CursorLineFold = { link = "FoldColumn" },
		Folded = { fg = p.fold_fg, bg = p.fold_bg },

		-- selection / search / brackets -------------------------------------------------
		Visual = { bg = p.sel },
		VisualNOS = { bg = p.sel_inactive },
		Search = { bg = p.search },
		CurSearch = { bg = p.sel },
		IncSearch = { link = "CurSearch" },
		Substitute = { bg = p.search_write },
		MatchParen = { fg = p.brace_fg, bg = p.brace_bg, bold = true },
		QuickFixLine = { bg = p.inactive_sel },
		SnippetTabstop = { bg = p.sel_inactive },

		-- popup menu -----------------------------------------------------------------------
		Pmenu = { fg = p.ui_fg, bg = p.popup },
		PmenuSel = { bg = p.completion_sel },
		PmenuKind = { fg = p.ui_dim, bg = p.popup },
		PmenuKindSel = { fg = p.ui_dim, bg = p.completion_sel },
		PmenuExtra = { fg = p.ui_dim, bg = p.popup },
		PmenuExtraSel = { fg = p.ui_dim, bg = p.completion_sel },
		PmenuMatch = { fg = p.ctrl_click, bg = p.popup },
		PmenuMatchSel = { fg = p.ctrl_click, bg = p.completion_sel },
		PmenuBorder = { fg = p.tearline, bg = p.popup },
		PmenuSbar = { bg = p.popup },
		PmenuThumb = { bg = p.tearline },
		WildMenu = { link = "PmenuSel" },
		ComplMatchIns = { fg = p.comment },

		-- status / tabs / winbar ------------------------------------------------------------
		StatusLine = { fg = p.ui_fg, bg = p.panel },
		StatusLineNC = { fg = p.ui_dim, bg = p.panel },
		StatusLineTerm = { link = "StatusLine" },
		StatusLineTermNC = { link = "StatusLineNC" },
		TabLine = { fg = p.ui_fg, bg = p.panel },
		TabLineFill = { bg = p.panel },
		TabLineSel = { fg = p.ui_fg, bg = p.bg },
		WinBar = { fg = p.ui_fg, bg = p.bg },
		WinBarNC = { fg = p.ui_dim, bg = p.bg },
		MsgSeparator = { fg = p.tearline, bg = p.panel },

		-- messages ---------------------------------------------------------------------------
		Title = { fg = p.ui_fg, bold = true },
		Directory = { fg = p.number },
		ErrorMsg = { fg = p.error_text },
		WarningMsg = { fg = p.warn },
		MoreMsg = { fg = p.ui_fg, bold = true },
		ModeMsg = { fg = p.ui_fg, bold = true },
		Question = { fg = p.number },
		NvimInternalError = { fg = p.error_text },
		healthError = { fg = p.error_text },
		healthSuccess = { fg = p.fs_added },
		healthWarning = { fg = p.warn },

		-- text attributes ---------------------------------------------------------------------
		Bold = { bold = true },
		Italic = { italic = true },
		Underlined = { fg = p.link, underline = true },
		Todo = { fg = p.todo, italic = true },
		Error = { sp = p.error, undercurl = true },

		-- diff -----------------------------------------------------------------------------------
		DiffAdd = { bg = p.diff_add },
		DiffDelete = { fg = p.gutter_del, bg = p.diff_del },
		DiffChange = { bg = p.diff_mod },
		DiffText = { bg = p.diff_mod_stripe },
		Added = { fg = p.fs_added },
		Changed = { fg = p.fs_modified },
		Removed = { fg = p.fs_conflict },

		-- spell ------------------------------------------------------------------------------------
		SpellBad = { sp = p.typo, undercurl = true },
		SpellCap = { sp = p.number, undercurl = true },
		SpellRare = { sp = p.constant, undercurl = true },
		SpellLocal = { sp = p.ansi.cyan, undercurl = true },

		-- diagnostics --------------------------------------------------------------------------------
		DiagnosticError = { fg = p.error_text },
		DiagnosticWarn = { fg = p.warn },
		DiagnosticInfo = { fg = p.info },
		DiagnosticHint = { fg = p.fold_fg },
		DiagnosticOk = { fg = p.fs_added },
		DiagnosticUnderlineError = { sp = p.error, undercurl = true },
		DiagnosticUnderlineWarn = { bg = p.warn_bg }, -- Darcula warnings are a tinted background
		DiagnosticUnderlineInfo = { sp = p.info, undercurl = true },
		DiagnosticUnderlineHint = { sp = p.fold_fg, underdotted = true },
		DiagnosticUnderlineOk = { sp = p.fs_added, underline = true },
		DiagnosticUnnecessary = { fg = p.unused },
		DiagnosticDeprecated = { sp = p.deprecated, strikethrough = true },

		-- lsp ui ---------------------------------------------------------------------------------------
		LspReferenceText = { bg = p.ref_read },
		LspReferenceRead = { bg = p.ref_read },
		LspReferenceWrite = { bg = p.ref_write },
		LspReferenceTarget = { link = "LspReferenceText" },
		LspInlayHint = { fg = p.inlay_fg, bg = p.inlay_bg },
		LspCodeLens = { fg = p.ui_dim },
		LspCodeLensSeparator = { fg = p.tearline },
		LspSignatureActiveParameter = { bg = p.param_cur },

		-- debugger (nvim builtins used by nvim-dap signs) ----------------------------------------
		debugPC = { bg = p.exec_pt },
		debugBreakpoint = { fg = p.fs_conflict },
	}

	for _, sev in ipairs { "Error", "Warn", "Info", "Hint", "Ok" } do
		g["DiagnosticVirtualText" .. sev] = { link = "Diagnostic" .. sev }
		g["DiagnosticVirtualLines" .. sev] = { link = "Diagnostic" .. sev }
		g["DiagnosticFloating" .. sev] = { link = "Diagnostic" .. sev }
		g["DiagnosticSign" .. sev] = { link = "Diagnostic" .. sev }
	end

	return g
end
