-- Darcula palette for darculafo.
--
-- Every value below was read from the Darcula scheme bundled with GoLand 2026.2:
--   * DefaultColorSchemesManager.xml  (platform "Darcula", parent "Default")
--   * GoDarcula.xml                    (Go plugin overrides)
--   * darcula.theme.json               (look-and-feel / UI chrome)
-- The comment after each entry names the JetBrains key it comes from. Entries marked
-- "derived" are blends of Darcula colours for things JetBrains has no key for.

local p = {
	-- editor canvas ----------------------------------------------------------------
	bg = "#2b2b2b", -- TEXT background
	fg = "#a9b7c6", -- TEXT foreground
	caret_row = "#323232", -- CARET_ROW_COLOR
	gutter = "#313335", -- GUTTER_BACKGROUND
	line_nr = "#606366", -- LINE_NUMBERS_COLOR
	line_nr_cur = "#a4a3a3", -- LINE_NUMBER_ON_CARET_ROW_COLOR
	caret = "#bbbbbb", -- CARET_COLOR
	sel = "#214283", -- SELECTION_BACKGROUND
	sel_inactive = "#4c4f56", -- SELECTION_BACKGROUND_INACTIVE
	whitespace = "#606060", -- WHITESPACES
	guide = "#373737", -- INDENT_GUIDE
	guide_sel = "#505050", -- SELECTED_INDENT_GUIDE
	margin = "#4d4d4d", -- RIGHT_MARGIN_COLOR / METHOD_SEPARATORS_COLOR
	fold_fg = "#8c8c8c", -- FOLDED_TEXT_ATTRIBUTES foreground
	fold_bg = "#3a3a3a", -- FOLDED_TEXT_ATTRIBUTES background
	tearline = "#555555", -- TEARLINE_COLOR

	-- ui chrome (darcula.theme.json) -----------------------------------------------
	panel = "#3c3f41", -- Panel.background: status bar, tool windows, editor tabs
	popup = "#46484a", -- LOOKUP_COLOR / DOCUMENTATION_COLOR: completion + doc popups
	tooltip = "#4b4d4d", -- ToolTip.background
	border = "#323232", -- Borders.ContrastBorderColor
	ui_fg = "#bbbbbb", -- default label foreground
	ui_dim = "#787878", -- infoForeground
	ui_info = "#919191", -- StatusBar.infoForeground
	disabled = "#777777", -- disabledForeground
	completion_sel = "#113a5c", -- CompletionPopup.selectionBackground
	inactive_sel = "#0d293e", -- selectionInactiveBackground
	notification = "#1d3857", -- NOTIFICATION_BACKGROUND

	-- code -------------------------------------------------------------------------
	comment = "#808080", -- DEFAULT_LINE_COMMENT / DEFAULT_BLOCK_COMMENT
	doc_comment = "#629755", -- DEFAULT_DOC_COMMENT
	doc_markup = "#77b767", -- DEFAULT_DOC_MARKUP
	doc_tag_value = "#8a653b", -- DEFAULT_DOC_COMMENT_TAG_VALUE
	keyword = "#cc7832", -- DEFAULT_KEYWORD, DEFAULT_COMMA, DEFAULT_SEMICOLON
	string = "#6a8759", -- DEFAULT_STRING
	escape = "#cc7832", -- DEFAULT_VALID_STRING_ESCAPE
	number = "#6897bb", -- DEFAULT_NUMBER
	constant = "#9876aa", -- DEFAULT_CONSTANT (italic), DEFAULT_INSTANCE_FIELD
	metadata = "#bbb529", -- DEFAULT_METADATA: annotations, attributes, decorators
	func_decl = "#ffc66d", -- DEFAULT_FUNCTION_DECLARATION
	class_ref = "#769aa5", -- DEFAULT_CLASS_REFERENCE (languages other than Go)
	template_var = "#ae8abe", -- TEMPLATE_VARIABLE_ATTRIBUTES
	todo = "#a8c023", -- TODO_DEFAULT_ATTRIBUTES (italic)
	link = "#287bde", -- HYPERLINK_ATTRIBUTES
	ctrl_click = "#589df6", -- CTRL_CLICKABLE

	-- Go plugin (GoDarcula.xml) ----------------------------------------------------
	func_call_go = "#b09d79", -- GO_EXPORTED_FUNCTION_CALL / GO_LOCAL_FUNCTION_CALL
	type_ref_go = "#6fafbd", -- GO_TYPE_REFERENCE
	builtin_go = "#cc7832", -- GO_BUILTIN_TYPE_REFERENCE / _FUNCTION_CALL / _CONSTANT / _VARIABLE
	package_go = "#afbf7e", -- GO_PACKAGE
	receiver_go = "#4eade5", -- GO_METHOD_RECEIVER
	shadow_go = "#7dbda2", -- GO_SHADOWING_VARIABLE (needs flow analysis; unused)
	comment_ref_go = "#a1a1a1", -- GO_COMMENT_REFERENCE

	-- diagnostics --------------------------------------------------------------------
	error = "#bc3f3c", -- ERRORS_ATTRIBUTES wave / WRONG_REFERENCES_ATTRIBUTES
	error_text = "#ff6b68", -- CONSOLE_ERROR_OUTPUT
	warn_bg = "#52503a", -- WARNING_ATTRIBUTES background
	warn = "#be9117", -- WARNING_ATTRIBUTES error stripe
	info = "#aeae80", -- INFO_ATTRIBUTES wave
	typo = "#659c6b", -- TYPO wave
	unused = "#72737a", -- NOT_USED_ELEMENT_ATTRIBUTES
	deprecated = "#c3c3c3", -- DEPRECATED_ATTRIBUTES strikeout
	runtime_error = "#f49810", -- RUNTIME_ERROR

	-- editor feedback ------------------------------------------------------------------
	brace_fg = "#ffef28", -- MATCHED_BRACE_ATTRIBUTES foreground
	brace_bg = "#3b514d", -- MATCHED_BRACE_ATTRIBUTES background
	unmatched = "#d1243b", -- UNMATCHED_BRACE_ATTRIBUTES
	search = "#32593d", -- TEXT_SEARCH_RESULT_ATTRIBUTES
	search_usage = "#155221", -- SEARCH_RESULT_ATTRIBUTES
	search_write = "#532b2e", -- WRITE_SEARCH_RESULT_ATTRIBUTES
	ref_read = "#344134", -- IDENTIFIER_UNDER_CARET_ATTRIBUTES
	ref_write = "#40332b", -- WRITE_IDENTIFIER_UNDER_CARET_ATTRIBUTES
	inlay_fg = "#787878", -- INLAY_DEFAULT foreground
	inlay_bg = "#3b3b3b", -- INLAY_DEFAULT background
	param_cur = "#305d78", -- INLINE_PARAMETER_HINT_CURRENT background
	injected = "#364135", -- INJECTED_LANGUAGE_FRAGMENT
	live_template = "#80bfff", -- LIVE_TEMPLATE_ATTRIBUTES

	-- debugger -------------------------------------------------------------------------
	exec_pt = "#2d6099", -- EXECUTIONPOINT_ATTRIBUTES
	breakpoint = "#3a2323", -- BREAKPOINT_ATTRIBUTES
	inlined_value = "#666d75", -- DEBUGGER_INLINED_VALUES
	inlined_modified = "#ca7e03", -- DEBUGGER_INLINED_VALUES_MODIFIED

	-- diff / vcs -------------------------------------------------------------------------
	diff_add = "#294436", -- DIFF_INSERTED
	diff_add_stripe = "#447152", -- DIFF_INSERTED error stripe
	diff_del = "#484a4a", -- DIFF_DELETED
	diff_del_stripe = "#656e76", -- DIFF_DELETED error stripe
	diff_mod = "#385570", -- DIFF_MODIFIED
	diff_mod_stripe = "#43698d", -- DIFF_MODIFIED error stripe
	diff_conflict = "#45302b", -- DIFF_CONFLICT
	gutter_add = "#384c38", -- ADDED_LINES_COLOR
	gutter_mod = "#374752", -- MODIFIED_LINES_COLOR
	gutter_del = "#656e76", -- DELETED_LINES_COLOR
	fs_added = "#629755", -- FILESTATUS_ADDED
	fs_modified = "#6897bb", -- FILESTATUS_MODIFIED
	fs_deleted = "#6c6c6c", -- FILESTATUS_DELETED
	fs_untracked = "#d1675a", -- FILESTATUS_UNKNOWN
	fs_ignored = "#848504", -- FILESTATUS_IDEA_FILESTATUS_IGNORED
	fs_conflict = "#d5756c", -- FILESTATUS_*_CONFLICTS
	fs_renamed = "#3a8484", -- FILESTATUS_RENAMED
	fs_merged = "#9876aa", -- FILESTATUS_MERGED
	staged_add = "#313b31", -- derived: gutter_add blended 50% into bg
	staged_mod = "#31393e", -- derived: gutter_mod blended 50% into bg
	staged_del = "#484c50", -- derived: gutter_del blended 50% into bg

	-- other languages ----------------------------------------------------------------------
	md_header_bg = "#3c3f41", -- MARKDOWN_HEADER background
	yaml_anchor = "#e8bf6a", -- YAML_ANCHOR
	html_tag = "#e8bf6a", -- HTML_TAG_NAME (Darcula XML defaults)
	html_attr = "#bababa", -- HTML_ATTRIBUTE_NAME
	html_value = "#a5c261", -- HTML_ATTRIBUTE_VALUE
	html_entity = "#6d9cbe", -- HTML_ENTITY_REFERENCE

	-- console / ANSI (CONSOLE_*_OUTPUT) ---------------------------------------------------
	ansi = {
		black = "#000000",
		red = "#f0524f",
		green = "#5c962c",
		yellow = "#a68a0d",
		blue = "#3993d4",
		magenta = "#a771bf",
		cyan = "#00a3a3",
		white = "#bbbbbb", -- CONSOLE_NORMAL_OUTPUT (CONSOLE_WHITE_OUTPUT is pure white)
		bright_black = "#595959", -- CONSOLE_DARKGRAY_OUTPUT
		bright_red = "#ff4050",
		bright_green = "#4fc414",
		bright_yellow = "#e5bf00",
		bright_blue = "#1fb0ff",
		bright_magenta = "#ed7eed",
		bright_cyan = "#00e5e5",
		bright_white = "#ffffff",
	},
}

-- A typo in a palette key must fail loudly, not render as "no colour".
return setmetatable(p, {
	__index = function(_, key)
		error(("darculafo: unknown palette key %q"):format(tostring(key)), 2)
	end,
})
