-- Plugin highlight groups. Each block is gated by cfg.integrations.<flag>.
---@param p table palette
---@param cfg table config
---@return table<string, vim.api.keyset.highlight>
return function(p, cfg)
	local i = cfg.integrations
	local g = {}
	local function add(t)
		for k, v in pairs(t) do
			g[k] = v
		end
	end

	if i.gitsigns then
		add {
			GitSignsAdd = { fg = p.gutter_add },
			GitSignsChange = { fg = p.gutter_mod },
			GitSignsDelete = { fg = p.gutter_del },
			GitSignsTopdelete = { fg = p.gutter_del },
			GitSignsChangedelete = { fg = p.gutter_mod },
			GitSignsUntracked = { fg = p.fs_untracked },
			GitSignsAddNr = { fg = p.fs_added },
			GitSignsChangeNr = { fg = p.fs_modified },
			GitSignsDeleteNr = { fg = p.fs_deleted },
			GitSignsTopdeleteNr = { fg = p.fs_deleted },
			GitSignsChangedeleteNr = { fg = p.fs_modified },
			GitSignsUntrackedNr = { fg = p.fs_untracked },
			GitSignsAddLn = { bg = p.diff_add },
			GitSignsChangeLn = { bg = p.diff_mod },
			GitSignsChangedeleteLn = { bg = p.diff_mod },
			GitSignsUntrackedLn = { bg = p.diff_add },
			GitSignsStagedAdd = { fg = p.staged_add },
			GitSignsStagedChange = { fg = p.staged_mod },
			GitSignsStagedDelete = { fg = p.staged_del },
			GitSignsStagedTopdelete = { fg = p.staged_del },
			GitSignsStagedChangedelete = { fg = p.staged_mod },
			GitSignsStagedUntracked = { fg = p.staged_add },
			GitSignsAddPreview = { link = "DiffAdd" },
			GitSignsDeletePreview = { link = "DiffDelete" },
			GitSignsAddInline = { bg = p.diff_add_stripe },
			GitSignsChangeInline = { bg = p.diff_mod_stripe },
			GitSignsDeleteInline = { bg = p.diff_del_stripe },
			GitSignsAddLnInline = { link = "GitSignsAddInline" },
			GitSignsChangeLnInline = { link = "GitSignsChangeInline" },
			GitSignsDeleteLnInline = { link = "GitSignsDeleteInline" },
			GitSignsDeleteVirtLn = { link = "DiffDelete" },
			GitSignsDeleteVirtLnInLine = { link = "GitSignsDeleteInline" },
			GitSignsVirtLnum = { fg = p.line_nr },
			GitSignsCurrentLineBlame = { fg = p.ui_dim },
		}
	end

	-- completion kinds shared by blink.cmp and the nvim-cmp aliases
	local kinds = {
		Text = p.ui_dim,
		Snippet = p.ui_dim,
		Keyword = p.keyword,
		Function = p.func_decl,
		Method = p.func_decl,
		Constructor = p.func_decl,
		Class = p.type_ref_go,
		Struct = p.type_ref_go,
		Interface = p.type_ref_go,
		Enum = p.type_ref_go,
		TypeParameter = p.type_ref_go,
		Module = p.package_go,
		Constant = p.constant,
		EnumMember = p.constant,
		Variable = p.fg,
		Field = p.fg,
		Property = p.fg,
		Event = p.fg,
		Operator = p.fg,
		Value = p.number,
		Unit = p.number,
		Color = p.number,
		File = p.ui_fg,
		Folder = p.ui_fg,
		Reference = p.ui_fg,
		Copilot = p.ctrl_click,
	}

	if i.blink then
		add {
			BlinkCmpMenu = { fg = p.ui_fg, bg = p.popup },
			BlinkCmpMenuBorder = { fg = p.tearline, bg = p.popup },
			BlinkCmpMenuSelection = { bg = p.completion_sel },
			BlinkCmpScrollBarThumb = { bg = p.tearline },
			BlinkCmpScrollBarGutter = { bg = p.popup },
			BlinkCmpLabel = { fg = p.ui_fg },
			BlinkCmpLabelMatch = { fg = p.ctrl_click },
			BlinkCmpLabelDeprecated = { fg = p.disabled, strikethrough = true },
			BlinkCmpLabelDetail = { fg = p.ui_dim },
			BlinkCmpLabelDescription = { fg = p.ui_dim },
			BlinkCmpSource = { fg = p.ui_dim },
			BlinkCmpKind = { fg = p.ui_dim },
			BlinkCmpGhostText = { fg = p.comment },
			BlinkCmpDoc = { fg = p.ui_fg, bg = p.popup },
			BlinkCmpDocBorder = { fg = p.tearline, bg = p.popup },
			BlinkCmpDocSeparator = { fg = p.tearline, bg = p.popup },
			BlinkCmpDocCursorLine = { bg = p.caret_row },
			BlinkCmpSignatureHelp = { fg = p.ui_fg, bg = p.popup },
			BlinkCmpSignatureHelpBorder = { fg = p.tearline, bg = p.popup },
			BlinkCmpSignatureHelpActiveParameter = { bg = p.param_cur },
		}
		for kind, color in pairs(kinds) do
			g["BlinkCmpKind" .. kind] = { fg = color }
		end
	end

	if i.nvim_cmp then
		add {
			CmpItemAbbr = { fg = p.ui_fg },
			CmpItemAbbrMatch = { fg = p.ctrl_click },
			CmpItemAbbrMatchFuzzy = { fg = p.ctrl_click },
			CmpItemAbbrDeprecated = { fg = p.disabled, strikethrough = true },
			CmpItemMenu = { fg = p.ui_dim },
			CmpItemKind = { fg = p.ui_dim },
			CmpGhostText = { fg = p.comment },
		}
		for kind, color in pairs(kinds) do
			g["CmpItemKind" .. kind] = { fg = color }
		end
	end

	if i.mini then
		add {
			-- mini.pick
			MiniPickNormal = { fg = p.ui_fg, bg = p.panel },
			MiniPickBorder = { fg = p.tearline, bg = p.panel },
			MiniPickBorderBusy = { fg = p.warn, bg = p.panel },
			MiniPickBorderText = { fg = p.ui_fg, bg = p.panel, bold = true },
			MiniPickPrompt = { fg = p.ui_fg, bg = p.panel },
			MiniPickPromptCaret = { fg = p.ui_fg, bg = p.panel },
			MiniPickPromptPrefix = { fg = p.keyword, bg = p.panel },
			MiniPickHeader = { fg = p.ui_dim, bg = p.panel },
			MiniPickMatchCurrent = { bg = p.completion_sel },
			MiniPickMatchMarked = { bg = p.ref_write },
			MiniPickMatchRanges = { fg = p.ctrl_click, bold = true },
			MiniPickPreviewLine = { bg = p.caret_row },
			MiniPickPreviewRegion = { bg = p.sel },
			MiniPickIconDirectory = { link = "Directory" },
			MiniPickIconFile = { fg = p.ui_fg },
			-- mini.cursorword
			MiniCursorword = { bg = p.ref_read },
			MiniCursorwordCurrent = { bg = p.ref_read },
			-- mini.clue
			MiniClueBorder = { fg = p.tearline, bg = p.panel },
			MiniClueTitle = { fg = p.ui_fg, bg = p.panel, bold = true },
			MiniClueSeparator = { fg = p.tearline, bg = p.panel },
			MiniClueNextKey = { fg = p.keyword, bg = p.panel },
			MiniClueNextKeyWithPostkeys = { fg = p.func_decl, bg = p.panel },
			MiniClueDescGroup = { fg = p.package_go, bg = p.panel },
			MiniClueDescSingle = { fg = p.ui_fg, bg = p.panel },
		}
	end

	if i.ibl then
		add {
			IblIndent = { fg = p.guide, nocombine = true },
			IblScope = { fg = p.guide_sel, nocombine = true },
			IblWhitespace = { fg = p.whitespace, nocombine = true },
		}
	end

	if i.treesitter_context then
		add {
			TreesitterContext = { bg = p.bg },
			TreesitterContextBottom = { sp = p.tearline, underline = true },
			TreesitterContextSeparator = { fg = p.tearline },
			TreesitterContextLineNumber = { fg = p.line_nr, bg = p.gutter },
			TreesitterContextLineNumberBottom = {
				fg = p.line_nr,
				bg = p.gutter,
				sp = p.tearline,
				underline = true,
			},
		}
	end

	if i.oil then
		add {
			OilDir = { link = "Directory" },
			OilDirIcon = { link = "Directory" },
			OilLink = { fg = p.link },
			OilLinkTarget = { fg = p.ui_dim },
			OilFile = { fg = p.fg },
			OilHidden = { fg = p.disabled },
			OilSocket = { fg = p.template_var },
			OilCreate = { fg = p.fs_added },
			OilDelete = { fg = p.fs_conflict },
			OilMove = { fg = p.fs_modified },
			OilCopy = { fg = p.fs_modified },
			OilChange = { fg = p.warn },
			OilRestore = { fg = p.fs_added },
			OilPurge = { fg = p.fs_conflict },
			OilTrash = { fg = p.fs_conflict },
		}
	end

	if i.grug_far then
		add {
			GrugFarResultsMatch = { bg = p.search },
			GrugFarResultsPath = { fg = p.ctrl_click },
			GrugFarResultsLineNr = { fg = p.line_nr },
			GrugFarResultsColumnNr = { fg = p.line_nr },
			GrugFarResultsNumberLabel = { fg = p.number },
			GrugFarResultsHeader = { fg = p.ui_dim },
			GrugFarResultsStats = { fg = p.ui_dim },
			GrugFarResultsCmdHeader = { fg = p.ui_dim },
			GrugFarResultsActionMessage = { fg = p.fs_added },
			GrugFarResultsChangeIndicator = { fg = p.fs_modified },
			GrugFarResultsAddIndicator = { fg = p.fs_added },
			GrugFarResultsRemoveIndicator = { fg = p.fs_conflict },
			GrugFarResultsDiffSeparatorIndicator = { fg = p.tearline },
			GrugFarHelpHeader = { fg = p.ui_dim },
			GrugFarHelpHeaderKey = { fg = p.keyword },
			GrugFarInputLabel = { fg = p.keyword },
			GrugFarInputPlaceholder = { fg = p.ui_dim },
		}
	end

	if i.dap then
		add {
			DapBreakpoint = { fg = p.fs_conflict },
			DapBreakpointCondition = { fg = p.warn },
			DapBreakpointRejected = { fg = p.disabled },
			DapLogPoint = { fg = p.number },
			DapStopped = { fg = p.fs_added },
			DapStoppedLine = { bg = p.exec_pt },
			DapUIVariable = { fg = p.fg },
			DapUIScope = { fg = p.number },
			DapUIType = { fg = p.type_ref_go },
			DapUIValue = { fg = p.fg },
			DapUIModifiedValue = { fg = p.inlined_modified, bold = true },
			DapUIDecoration = { fg = p.number },
			DapUIThread = { fg = p.fs_added },
			DapUIStoppedThread = { fg = p.number },
			DapUIFrameName = { fg = p.fg },
			DapUISource = { fg = p.package_go },
			DapUILineNumber = { fg = p.number },
			DapUIFloatNormal = { link = "NormalFloat" },
			DapUIFloatBorder = { fg = p.tearline },
			DapUIWatchesEmpty = { fg = p.fs_conflict },
			DapUIWatchesValue = { fg = p.fs_added },
			DapUIWatchesError = { fg = p.fs_conflict },
			DapUIBreakpointsPath = { fg = p.number },
			DapUIBreakpointsInfo = { fg = p.fs_added },
			DapUIBreakpointsCurrentLine = { fg = p.fs_added, bold = true },
			DapUIBreakpointsLine = { link = "DapUILineNumber" },
			DapUIBreakpointsDisabledLine = { fg = p.disabled },
			DapUICurrentFrameName = { link = "DapUIBreakpointsCurrentLine" },
			DapUIStepOver = { fg = p.number },
			DapUIStepInto = { fg = p.number },
			DapUIStepBack = { fg = p.number },
			DapUIStepOut = { fg = p.number },
			DapUIStop = { fg = p.fs_conflict },
			DapUIPlayPause = { fg = p.fs_added },
			DapUIRestart = { fg = p.fs_added },
			DapUIUnavailable = { fg = p.disabled },
			DapUIWinSelect = { fg = p.keyword, bold = true },
			DapUIEndofBuffer = { link = "EndOfBuffer" },
			NvimDapVirtualText = { fg = p.inlined_value, italic = true },
			NvimDapVirtualTextChanged = { fg = p.inlined_modified, italic = true },
			NvimDapVirtualTextError = { fg = p.error_text, italic = true },
			NvimDapVirtualTextInfo = { fg = p.inlined_value, italic = true },
		}
		for _, n in ipairs {
			"PlayPause",
			"Restart",
			"Stop",
			"Unavailable",
			"StepOver",
			"StepInto",
			"StepBack",
			"StepOut",
		} do
			g["DapUI" .. n .. "NC"] = { link = "DapUI" .. n }
		end
	end

	if i.copilot then
		add {
			CopilotSuggestion = { fg = p.comment },
			CopilotAnnotation = { fg = p.ui_dim },
		}
	end

	if i.telescope then
		add {
			TelescopeNormal = { fg = p.ui_fg, bg = p.panel },
			TelescopeBorder = { fg = p.tearline, bg = p.panel },
			TelescopePromptNormal = { fg = p.ui_fg, bg = p.panel },
			TelescopePromptBorder = { fg = p.tearline, bg = p.panel },
			TelescopeTitle = { fg = p.ui_fg, bold = true },
			TelescopeSelection = { bg = p.completion_sel },
			TelescopeSelectionCaret = { fg = p.keyword, bg = p.completion_sel },
			TelescopeMultiSelection = { bg = p.ref_write },
			TelescopeMatching = { fg = p.ctrl_click, bold = true },
			TelescopePromptPrefix = { fg = p.keyword },
			TelescopePromptCounter = { fg = p.ui_dim },
			TelescopePreviewLine = { bg = p.caret_row },
			TelescopeResultsDiffAdd = { fg = p.fs_added },
			TelescopeResultsDiffChange = { fg = p.fs_modified },
			TelescopeResultsDiffDelete = { fg = p.fs_conflict },
			TelescopeResultsDiffUntracked = { fg = p.fs_untracked },
		}
	end

	if i.mason then
		add {
			MasonHeader = { fg = p.bg, bg = p.func_decl, bold = true },
			MasonHeaderSecondary = { fg = p.bg, bg = p.number, bold = true },
			MasonHeading = { fg = p.ui_fg, bold = true },
			MasonHighlight = { fg = p.number },
			MasonHighlightBlock = { fg = p.bg, bg = p.fs_added },
			MasonHighlightBlockBold = { fg = p.bg, bg = p.fs_added, bold = true },
			MasonHighlightSecondary = { fg = p.func_decl },
			MasonHighlightBlockSecondary = { fg = p.bg, bg = p.func_decl },
			MasonHighlightBlockBoldSecondary = {
				fg = p.bg,
				bg = p.func_decl,
				bold = true,
			},
			MasonMuted = { fg = p.ui_dim },
			MasonMutedBlock = { fg = p.bg, bg = p.ui_dim },
			MasonMutedBlockBold = { fg = p.bg, bg = p.ui_dim, bold = true },
			MasonError = { fg = p.error_text },
			MasonWarning = { fg = p.warn },
		}
	end

	return g
end
