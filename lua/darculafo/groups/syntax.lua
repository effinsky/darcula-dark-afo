-- Legacy syntax groups, treesitter captures (with per-language variants) and
-- LSP semantic-token groups.
---@param p table palette
---@param cfg table config
---@return table<string, vim.api.keyset.highlight>
return function(p, cfg)
	local g = {}
	local function add(t)
		for k, v in pairs(t) do
			g[k] = v
		end
	end
	local function alias(from, to) g[from] = { link = to } end

	-- legacy :syntax groups (help, man, quickfix, any filetype without a parser) -------
	add {
		Comment = { fg = p.comment },
		SpecialComment = { fg = p.doc_comment },
		Constant = { fg = p.constant, italic = true },
		String = { fg = p.string },
		Character = { fg = p.string },
		Number = { fg = p.number },
		Float = { fg = p.number },
		Boolean = { fg = p.keyword },
		Identifier = { fg = p.fg },
		Function = { fg = p.func_decl },
		Statement = { fg = p.keyword },
		Conditional = { fg = p.keyword },
		Repeat = { fg = p.keyword },
		Label = { fg = p.keyword },
		Operator = { fg = p.fg },
		Keyword = { fg = p.keyword },
		Exception = { fg = p.keyword },
		PreProc = { fg = p.keyword },
		Include = { fg = p.keyword },
		Define = { fg = p.keyword },
		Macro = { fg = p.keyword },
		PreCondit = { fg = p.keyword },
		Type = { fg = p.keyword },
		StorageClass = { fg = p.keyword },
		Structure = { fg = p.keyword },
		Typedef = { fg = p.keyword },
		Special = { fg = p.escape },
		SpecialChar = { fg = p.escape },
		Tag = { fg = p.html_tag },
		Delimiter = { fg = p.fg },
		Debug = { fg = p.comment },
	}

	-- git / diff syntax used by fugitive, gitcommit and `diff` buffers -----------------
	add {
		diffAdded = { link = "Added" },
		diffRemoved = { link = "Removed" },
		diffChanged = { link = "Changed" },
		diffLine = { fg = p.number },
		diffFile = { fg = p.ui_fg, bold = true },
		diffIndexLine = { fg = p.ui_dim },
		diffOldFile = { fg = p.ui_dim },
		diffNewFile = { fg = p.ui_dim },
		diffSubname = { fg = p.fg },
		gitcommitSummary = { fg = p.ui_fg },
		gitcommitOverflow = { fg = p.warn },
		gitcommitHeader = { fg = p.comment },
		gitcommitComment = { fg = p.comment },
		gitcommitOnBranch = { fg = p.comment },
		gitcommitBranch = { fg = p.number, bold = true },
		gitcommitSelectedType = { fg = p.comment },
		gitcommitDiscardedType = { fg = p.comment },
		gitcommitUnmergedType = { fg = p.comment },
		gitcommitSelected = { fg = p.comment },
		gitcommitDiscarded = { fg = p.comment },
		gitcommitUntracked = { fg = p.comment },
		gitcommitSelectedFile = { fg = p.fs_added },
		gitcommitDiscardedFile = { fg = p.fs_conflict },
		gitcommitUnmergedFile = { fg = p.fs_conflict, bold = true },
		gitcommitUntrackedFile = { fg = p.fs_untracked },
		fugitiveHeader = { fg = p.ui_fg, bold = true },
		fugitiveHeading = { fg = p.keyword },
		fugitiveSymbolicRef = { fg = p.number },
		fugitiveHash = { fg = p.number },
		fugitiveStagedHeading = { fg = p.fs_added },
		fugitiveUnstagedHeading = { fg = p.warn },
		fugitiveUntrackedHeading = { fg = p.fs_untracked },
		fugitiveStagedModifier = { fg = p.keyword },
		fugitiveUnstagedModifier = { fg = p.keyword },
	}

	-- treesitter: variables, constants, modules ----------------------------------------------
	add {
		["@variable"] = { fg = p.fg },
		["@variable.builtin"] = { fg = p.keyword },
		["@variable.parameter"] = { fg = p.fg },
		["@variable.parameter.builtin"] = { fg = p.keyword },
		["@variable.parameter.receiver"] = { fg = p.receiver_go }, -- after/queries/go
		["@variable.member"] = { fg = p.fg },
		["@property"] = { fg = p.fg },
		["@constant"] = { fg = p.constant, italic = true },
		["@constant.builtin"] = { fg = p.keyword },
		["@constant.macro"] = { link = "@constant" },
		["@module"] = { fg = p.package_go },
		["@module.builtin"] = { fg = p.package_go },
		["@label"] = { fg = p.fg, bold = true, underline = true, sp = p.comment },
	}

	-- literals ---------------------------------------------------------------------------------
	add {
		["@string"] = { fg = p.string },
		["@string.documentation"] = { fg = p.doc_comment },
		["@string.regexp"] = { fg = p.string },
		["@string.escape"] = { fg = p.escape },
		["@string.special"] = { fg = p.escape },
		["@string.special.symbol"] = { fg = p.string },
		["@string.special.path"] = { fg = p.string },
		["@string.special.url"] = { fg = p.link, underline = true },
		["@character"] = { fg = p.string },
		["@character.special"] = { fg = p.escape },
		["@boolean"] = { fg = p.keyword },
		["@number"] = { fg = p.number },
		["@number.float"] = { fg = p.number },
	}

	-- types / attributes -------------------------------------------------------------------------
	add {
		["@type"] = { fg = p.type_ref_go },
		["@type.builtin"] = { fg = p.builtin_go },
		["@type.definition"] = { fg = p.fg },
		["@type.qualifier"] = { fg = p.keyword },
		["@attribute"] = { fg = p.metadata },
		["@attribute.builtin"] = { fg = p.metadata },
	}

	-- functions ----------------------------------------------------------------------------------
	add {
		["@function"] = { fg = p.func_decl },
		["@function.method"] = { fg = p.func_decl },
		["@function.builtin"] = { fg = p.keyword },
		["@function.call"] = { fg = p.fg },
		["@function.method.call"] = { fg = p.fg },
		["@function.macro"] = { link = "@function.call" },
		["@constructor"] = { fg = p.fg },
		["@operator"] = { fg = p.fg },
	}

	-- keywords / punctuation -----------------------------------------------------------------------
	for _, k in ipairs {
		"@keyword",
		"@keyword.coroutine",
		"@keyword.function",
		"@keyword.operator",
		"@keyword.import",
		"@keyword.type",
		"@keyword.modifier",
		"@keyword.repeat",
		"@keyword.return",
		"@keyword.debug",
		"@keyword.exception",
		"@keyword.conditional",
		"@keyword.conditional.ternary",
		"@keyword.directive",
		"@keyword.directive.define",
		"@keyword.export",
	} do
		g[k] = { fg = p.keyword }
	end
	add {
		["@punctuation.bracket"] = { fg = p.fg },
		["@punctuation.delimiter"] = { fg = p.fg },
		["@punctuation.delimiter.comma"] = { fg = p.keyword }, -- after/queries/go
		["@punctuation.special"] = { fg = p.fg },
	}

	-- comments ---------------------------------------------------------------------------------------
	add {
		["@comment"] = { fg = p.comment },
		["@comment.documentation"] = { fg = p.doc_comment },
		["@comment.error"] = { fg = p.todo, italic = true },
		["@comment.warning"] = { fg = p.todo, italic = true },
		["@comment.todo"] = { fg = p.todo, italic = true },
		["@comment.note"] = { fg = p.todo, italic = true },
	}

	-- markup (markdown, help, rst) ---------------------------------------------------------------------
	add {
		["@markup.heading"] = { fg = p.ui_fg, bg = p.md_header_bg, bold = true },
		["@markup.strong"] = { bold = true },
		["@markup.italic"] = { italic = true },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },
		["@markup.quote"] = { fg = p.comment },
		["@markup.math"] = { fg = p.number },
		["@markup.environment"] = { fg = p.keyword },
		["@markup.link"] = { fg = p.link },
		["@markup.link.label"] = { fg = p.link },
		["@markup.link.url"] = { fg = p.link, underline = true },
		["@markup.raw"] = { fg = p.ui_fg, bg = p.gutter },
		["@markup.raw.block"] = { fg = p.ui_fg },
		["@markup.list"] = { fg = p.keyword },
		["@markup.list.checked"] = { fg = p.fs_added },
		["@markup.list.unchecked"] = { fg = p.ui_dim },
	}
	for i = 1, 6 do
		g["@markup.heading." .. i] = { link = "@markup.heading" }
	end

	-- tags (html, xml, jsx) ---------------------------------------------------------------------------
	add {
		["@tag"] = { fg = p.html_tag },
		["@tag.builtin"] = { fg = p.html_tag },
		["@tag.delimiter"] = { fg = p.html_tag },
		["@tag.attribute"] = { fg = p.html_attr },
		["@string.html"] = { fg = p.html_value },
		["@string.xml"] = { fg = p.html_value },
		["@character.special.html"] = { fg = p.html_entity },
		["@character.special.xml"] = { fg = p.html_entity },
	}

	-- per-language: Go gets its own call colour and undifferentiated doc comments -------------------------
	add {
		["@function.call.go"] = { fg = p.func_call_go },
		["@function.method.call.go"] = { fg = p.func_call_go },
		["@constructor.go"] = { fg = p.func_call_go },
		["@comment.documentation.go"] = { fg = p.comment },
	}
	-- per-language: keys in data formats
	add {
		["@property.json"] = { fg = p.constant },
		["@property.jsonc"] = { fg = p.constant },
		["@property.json5"] = { fg = p.constant },
		["@property.yaml"] = { fg = p.keyword },
		["@property.toml"] = { fg = p.keyword },
		["@label.yaml"] = { fg = p.yaml_anchor },
	}

	-- diff captures and misc -------------------------------------------------------------------------------
	add {
		["@diff.plus"] = { link = "Added" },
		["@diff.minus"] = { link = "Removed" },
		["@diff.delta"] = { link = "Changed" },
		["@none"] = {},
	}

	-- pre-0.10 capture names still emitted by some queries and plugins ----------------------------------
	alias("@field", "@variable.member")
	alias("@method", "@function.method")
	alias("@method.call", "@function.method.call")
	alias("@namespace", "@module")
	alias("@include", "@keyword.import")
	alias("@conditional", "@keyword.conditional")
	alias("@repeat", "@keyword.repeat")
	alias("@exception", "@keyword.exception")
	alias("@float", "@number.float")
	alias("@parameter", "@variable.parameter")
	alias("@string.regex", "@string.regexp")
	alias("@symbol", "@string.special.symbol")
	alias("@storageclass", "@keyword.modifier")
	alias("@define", "@keyword.directive.define")
	alias("@preproc", "@keyword.directive")
	alias("@text.strong", "@markup.strong")
	alias("@text.emphasis", "@markup.italic")
	alias("@text.underline", "@markup.underline")
	alias("@text.strike", "@markup.strikethrough")
	alias("@text.title", "@markup.heading")
	alias("@text.literal", "@markup.raw")
	alias("@text.uri", "@markup.link.url")
	alias("@text.reference", "@markup.link")
	alias("@text.math", "@markup.math")
	alias("@text.todo", "@comment.todo")
	alias("@text.note", "@comment.note")
	alias("@text.warning", "@comment.warning")
	alias("@text.danger", "@comment.error")

	-- LSP semantic tokens ------------------------------------------------------------------------------------
	-- Types that treesitter already colours correctly are made transparent ({}), so a
	-- token only changes colour when it carries information treesitter lacks.
	local transparent = {
		"variable",
		"parameter",
		"property",
		"function",
		"method",
		"macro",
		"string",
		"number",
		"regexp",
		"operator",
		"comment",
		"event",
	}
	if cfg.semantic_tokens then
		for _, t in ipairs(transparent) do
			g["@lsp.type." .. t] = {}
		end
		add {
			["@lsp.type.namespace"] = { fg = p.package_go },
			["@lsp.type.type"] = { fg = p.type_ref_go },
			["@lsp.type.class"] = { fg = p.type_ref_go },
			["@lsp.type.struct"] = { fg = p.type_ref_go },
			["@lsp.type.interface"] = { fg = p.type_ref_go },
			["@lsp.type.enum"] = { fg = p.type_ref_go },
			["@lsp.type.typeParameter"] = { fg = p.type_ref_go },
			["@lsp.type.enumMember"] = { fg = p.constant, italic = true },
			["@lsp.type.keyword"] = { fg = p.keyword },
			["@lsp.type.modifier"] = { fg = p.keyword },
			["@lsp.type.decorator"] = { fg = p.metadata },
			["@lsp.type.label"] = { link = "@label" },
			["@lsp.mod.deprecated"] = { sp = p.deprecated, strikethrough = true },
			-- gopls: calls vs definitions, builtins, constants, printf verbs
			["@lsp.type.function.go"] = { fg = p.func_call_go },
			["@lsp.type.method.go"] = { fg = p.func_call_go },
			["@lsp.typemod.function.definition.go"] = { fg = p.func_decl },
			["@lsp.typemod.method.definition.go"] = { fg = p.func_decl },
			["@lsp.typemod.function.defaultLibrary.go"] = { fg = p.builtin_go },
			["@lsp.typemod.type.defaultLibrary.go"] = { fg = p.builtin_go },
			["@lsp.typemod.type.definition.go"] = { fg = p.fg },
			["@lsp.typemod.variable.defaultLibrary.go"] = { fg = p.builtin_go },
			["@lsp.typemod.string.format.go"] = { fg = p.escape },
		}
		-- Constants are purple italic through @lsp.mod.readonly (priority 126) instead of
		-- the typemod (127): gopls marks nil/true/false/iota both readonly and defaultLibrary,
		-- and @lsp.typemod.variable.defaultLibrary at 127 must win for them. A cleared group
		-- falls back to its parent, so this is per language rather than generic-with-overrides;
		-- these are the languages whose JetBrains schemes paint constants purple.
		for _, ft in ipairs { "go", "java", "kotlin", "rust", "c", "cpp" } do
			g["@lsp.mod.readonly." .. ft] = { fg = p.constant, italic = true }
		end
		-- Keep the typemod explicitly cleared so nothing can ever sit at priority 127.
		g["@lsp.typemod.variable.readonly"] = {}
	else
		for _, t in ipairs {
			"namespace",
			"type",
			"class",
			"struct",
			"interface",
			"enum",
			"typeParameter",
			"enumMember",
			"keyword",
			"modifier",
			"decorator",
			"label",
		} do
			g["@lsp.type." .. t] = {}
		end
		for _, t in ipairs(transparent) do
			g["@lsp.type." .. t] = {}
		end
	end

	return g
end
