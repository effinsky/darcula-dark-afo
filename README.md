# darculafo

A Neovim colourscheme that reproduces JetBrains **Darcula** as GoLand actually renders
it. Every hex value comes from the scheme files bundled with GoLand 2026.2
(`DefaultColorSchemesManager.xml`, `GoDarcula.xml`, `darcula.theme.json`); the palette in
`lua/darculafo/palette.lua` names the JetBrains key behind each colour.

Requires Neovim 0.10+ (modern treesitter capture names) and `termguicolors`; the
`vim.pack` snippet below needs 0.12+.

## Install

```lua
-- vim.pack
vim.pack.add { "https://github.com/effinsky/darculafo" }
-- lazy.nvim
{ "effinsky/darculafo", priority = 1000 }
```

```lua
require("darculafo").setup {
	semantic_tokens = true, -- false: LSP tokens add no colour, treesitter decides everything
	integrations = {
		blink = true,
		nvim_cmp = true,
		gitsigns = true,
		mini = true, -- mini.pick, mini.cursorword, mini.clue
		ibl = true,
		treesitter_context = true,
		oil = true,
		grug_far = true,
		dap = true, -- nvim-dap, nvim-dap-ui, nvim-dap-virtual-text
		copilot = true,
		telescope = true,
		mason = true,
	},
}
vim.cmd.colorscheme "darculafo"
```

The older `setup { opt = { integrations = { lsp_semantics_token = ..., dap_nvim = ... } } }`
shape is still accepted.

## What maps to what

| Neovim | Darcula key | Colour |
|---|---|---|
| keywords, `true false nil iota`, builtin types and functions, commas | `DEFAULT_KEYWORD`, `GO_BUILTIN_*`, `DEFAULT_COMMA` | `#cc7832` |
| strings, runes | `DEFAULT_STRING` | `#6a8759` |
| escapes, printf verbs | `DEFAULT_VALID_STRING_ESCAPE` | `#cc7832` |
| numbers | `DEFAULT_NUMBER` | `#6897bb` |
| constants | `DEFAULT_CONSTANT` | `#9876aa` italic |
| function / method declarations | `DEFAULT_FUNCTION_DECLARATION` | `#ffc66d` |
| function / method calls (Go) | `GO_*_FUNCTION_CALL` | `#b09d79` |
| type references | `GO_TYPE_REFERENCE` | `#6fafbd` |
| package names | `GO_PACKAGE` | `#afbf7e` |
| method receiver (declaration) | `GO_METHOD_RECEIVER` | `#4eade5` |
| fields, parameters, locals, type declarations | `DEFAULT_IDENTIFIER` | `#a9b7c6` |
| comments (Go doc comments included) | `DEFAULT_LINE_COMMENT` | `#808080` |
| labels | `DEFAULT_LABEL` | bold, underlined |
| annotations / attributes / decorators | `DEFAULT_METADATA` | `#bbb529` |
| TODO / FIXME | `TODO_DEFAULT_ATTRIBUTES` | `#a8c023` italic |
| selection · caret row · line numbers · gutter | `SELECTION_BACKGROUND` · `CARET_ROW_COLOR` · `LINE_NUMBERS_COLOR` · `GUTTER_BACKGROUND` | `#214283` · `#323232` · `#606366` · `#313335` |
| search · word under caret (read / write) | `TEXT_SEARCH_RESULT` · `IDENTIFIER_UNDER_CARET` | `#32593d` · `#344134` / `#40332b` |
| matched brace | `MATCHED_BRACE_ATTRIBUTES` | `#ffef28` on `#3b514d` |
| error · warning · info · typo | `ERRORS` · `WARNING` · `INFO` · `TYPO` | wave `#bc3f3c` · bg `#52503a` · wave `#aeae80` · wave `#659c6b` |
| diff add · delete · change | `DIFF_INSERTED` · `DIFF_DELETED` · `DIFF_MODIFIED` | `#294436` · `#484a4a` · `#385570` |
| popups, completion, docs | `LOOKUP_COLOR`, `CompletionPopup.selectionBackground` | `#46484a`, `#113a5c` |
| panels, status line, pickers | `Panel.background` | `#3c3f41` |

Per-filetype touches: JSON keys are purple (`JSON.PROPERTY_KEY`), YAML/TOML keys are
keyword orange, YAML anchors `#e8bf6a`, Markdown headings bold on `#3c3f41`, HTML tags
`#e8bf6a` / attributes `#bababa` / values `#a5c261`.

`after/queries/go/highlights.scm` adds two captures the stock Go query lacks:
`@variable.parameter.receiver` and `@punctuation.delimiter.comma`.

### Semantic tokens

With gopls `semanticTokens = true`, the theme only colours tokens that carry information
treesitter lacks: builtin functions and types (`defaultLibrary`), constants (`readonly`,
applied through `@lsp.mod.readonly.<ft>` for go/java/kotlin/rust/c/cpp), declaration vs.
call (`definition`), and printf verbs (`format`). Plain `variable`,
`parameter`, `function` and `method` tokens are transparent so treesitter's choice stands.

### Known gaps

GoLand underlines reassigned variables and tints shadowing variables `#7dbda2`; both need
flow analysis Neovim does not have. Receiver colour applies at the declaration only.

## lualine

`lua/lualine/themes/darculafo.lua` is picked up automatically with `theme = "auto"`.

## Development

```sh
make test     # headless assertions against the palette
make lint     # stylua --check
make format
```
