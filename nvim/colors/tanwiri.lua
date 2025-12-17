-- Based on Zenesque https://www.vim.org/scripts/script.php?script_id=3340

-- Reset syntax and highlights
vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') == 1 then
    vim.cmd('syntax reset')
end

vim.g.colors_name = 'tanwiri'
vim.o.background = 'light'

-- Palette Definitions
local c = {
    base_fg     = '#757575',
    base_bg     = '#e0e0d8',
    float_bg    = '#d0d0c6',
    cursor_col  = '#e1e1d0',
    selection   = '#a9a9aa',
    color_col   = '#e6e6e6',
    fold_bg     = '#cccccc',
    fold_col_bg = '#cccbcb',
    search_bg   = '#c5c3c3',
    inc_search  = '#adadad',
    match_paren = '#a8a8a8',
    diff_add    = '#7a9a7a', -- Soft-Earth override
    diff_change = '#b59a6d', -- Soft-Earth override
    diff_del    = '#b57d7d', -- Soft-Earth override
    vim_err_bg  = '#313131',
    warn_bg     = '#ffe0d6',
}

local hl = vim.api.nvim_set_hl

-- Function to set groups easier
local function set_hl(groups)
    for group, opts in pairs(groups) do
        hl(0, group, opts)
    end
end

-- =============================================================================
-- BASE HIGHLIGHTS
-- =============================================================================
set_hl({
    Normal       = { fg = c.base_fg, bg = c.base_bg },
    NormalFloat  = { bg = c.float_bg },
    CursorLine   = { bg = c.float_bg },
    CursorColumn = { bg = c.cursor_col },
    LineNr       = { fg = c.base_fg, bg = 'NONE' },

    -- Syntax basics (mapped to base_fg per original theme)
    Constant     = { fg = c.base_fg, bg = 'NONE' },
    Statement    = { fg = c.base_fg, bg = 'NONE' },
    Function     = { fg = c.base_fg, bg = 'NONE' },
    String       = { fg = c.base_fg, bg = 'NONE' },
    Type         = { fg = c.base_fg, bg = 'NONE' },
    Conditional  = { fg = c.base_fg, bg = 'NONE' },
    Todo         = { fg = c.base_fg, bg = 'NONE' },
    Comment      = { fg = c.base_fg, bg = 'NONE' },

    PmenuSel     = { fg = c.base_fg, bg = c.selection },
    ColorColumn  = { bg = c.color_col },

    -- Cursor (Inverted)
    Cursor       = { fg = c.base_bg, bg = c.base_fg },
    CursorIM     = { fg = c.base_bg, bg = c.base_fg },
    lCursor      = { fg = c.base_bg, bg = c.base_fg },

    -- Diffs (Using the Soft-Earth overrides from end of file)
    DiffAdd      = { fg = c.diff_add, bg = 'NONE', bold = true },
    DiffChange   = { fg = c.diff_change, bg = 'NONE', bold = true },
    DiffDelete   = { fg = c.diff_del, bg = 'NONE', bold = true },
    DiffText     = { fg = c.base_fg, bg = '#bababa' },

    -- Diffs for fugitive
    diffAdded      = { fg = c.diff_add, bg = 'NONE', bold = true },
    diffRemoved   = { fg = c.diff_del, bg = 'NONE', bold = true },

    Directory    = { fg = c.base_fg, bg = c.base_bg },
    ErrorMsg     = { fg = c.base_fg, bg = 'NONE' },

    FoldColumn   = { fg = c.base_fg, bg = c.fold_col_bg },
    Folded       = { fg = c.base_fg, bg = c.fold_bg },

    IncSearch    = { fg = c.base_fg, bg = c.inc_search },
    Search       = { fg = c.base_fg, bg = c.search_bg },
    MatchParen   = { fg = c.base_fg, bg = c.match_paren },

    ModeMsg      = { fg = c.base_fg, bg = c.base_bg },
    MoreMsg      = { fg = c.base_fg, bg = c.base_bg },
    NonText      = { fg = c.base_fg, bg = c.base_bg },

    Pmenu        = { fg = c.base_fg, bg = c.float_bg },
    PmenuSbar    = { fg = c.base_fg, bg = c.base_bg },
    PmenuThumb   = { fg = c.base_fg, bg = c.base_bg },
    -- PmenuSel defined above

    Question     = { fg = c.base_fg, bg = c.base_bg },
    SignColumn   = { fg = c.base_fg, bg = c.base_bg },
    SpecialKey   = { fg = c.base_fg, bg = c.float_bg },

    -- Spell
    SpellBad     = { sp = c.base_fg, bg = '#d1cdcd' },
    SpellCap     = { sp = c.base_fg },
    SpellLocal   = { sp = c.base_fg },
    SpellRare    = { sp = c.base_fg },

    StatusLine   = { fg = c.base_fg, bg = c.base_bg },
    StatusLineNC = { fg = c.base_fg, bg = c.base_bg },
    TabLine      = { fg = c.base_fg, bg = c.base_bg },
    TabLineFill  = { fg = c.base_fg, bg = c.base_bg },
    TabLineSel   = { fg = c.base_fg, bg = c.base_bg },

    Title        = { fg = c.base_fg, bg = c.base_bg },
    VertSplit    = { fg = c.base_fg, bg = '#b9b9b9' },
    Visual       = { fg = c.base_fg, bg = c.float_bg },
    WarningMsg   = { fg = c.base_fg, bg = c.warn_bg },
    WildMenu     = { fg = c.base_fg, bg = '#c2c2c2' },

    -- Primitives
    Boolean      = { fg = c.base_fg, bg = 'NONE' },
    Identifier   = { fg = c.base_fg, bg = 'NONE' },
    Keyword      = { fg = c.base_fg, bg = 'NONE' },
    PreProc      = { fg = c.base_fg, bg = 'NONE' },
    Special      = { fg = c.base_fg, bg = 'NONE' },
    Ignore       = { fg = c.base_bg, bg = 'NONE' },
    Error        = { fg = c.base_fg, bg = 'NONE' },

    -- Vim specific
    VimError        = { fg = c.base_fg, bg = c.vim_err_bg },
    VimCommentTitle = { fg = c.base_fg, bg = c.base_bg },

    -- Quickfix
    qfFileName      = { fg = c.base_fg, bg = 'NONE' },
    qfLineNr        = { fg = c.base_fg, bg = 'NONE' },
    qfError         = { fg = c.base_fg, bg = '#c4c2c2' },

    -- HTML
    htmlLink        = { fg = c.base_fg, bg = 'NONE' },
    htmlTagName     = { fg = 'NONE', bg = 'NONE' },

    -- CSS
    cssBraces       = { fg = c.base_fg, bg = c.base_bg },

    -- JS
    javaScript      = { fg = c.base_fg, bg = 'NONE' },

    -- Python
    pythonDecorator = { fg = c.base_fg, bg = 'NONE' },
})

-- =============================================================================
-- LINKS
-- =============================================================================

local links = {
    pythonDecoratorFunction = 'pythonDecorator',
    htmlScriptTag           = 'htmlTagName',
    htmlTagN                = 'htmlTagName',
    htmlEndTag              = 'htmlTagName',
    htmlSpecialTagName      = 'htmlTagName',

    -- CSS Links
    cssRenderAttr    = 'Constant',
    cssTextAttr      = 'Constant',
    cssUIAttr        = 'Constant',
    cssTableAttr     = 'Constant',
    cssColorAttr     = 'Constant',
    cssBoxAttr       = 'Constant',
    cssCommonAttr    = 'Constant',
    cssFunctionName  = 'Constant',
    cssRenderProp    = 'Type',
    cssBoxProp       = 'cssRenderProp',

    cssTagName       = 'Statement',
    cssClassName     = 'cssTagName',
    cssIdentifier    = 'cssTagName',
    cssPseudoClass   = 'cssTagName',
    cssPseudoClassId = 'cssTagName',

    -- JS Links
    javaScriptFunction = 'Statement',
    javaScriptMember   = 'Statement',
    javaScriptValue    = 'Constant',

    -- ObjC Links
    objcClass        = 'Type',
    cocoaClass       = 'objcClass',
    objcSubclass     = 'objcClass',
    objcSuperclass   = 'objcClass',
    cocoaFunction    = 'Function',
    objcMethodName   = 'Identifier',
    objcMethodArg    = 'Normal',
    objcMessageName  = 'Identifier',

    -- Others
    javaType         = 'Statement',
    cppStatement     = 'Statement',
}

for src, target in pairs(links) do
    hl(0, src, { link = target })
end

-- =============================================================================
-- MODERN HIGHLIGHTING (TreeSitter & LSP) - "Flattening"
-- =============================================================================

-- 1. Create a specific group for text only (Background MUST be NONE)
-- This ensures the CursorLine background can shine through the text.
hl(0, 'TanwiriUniformText', { fg = c.base_fg, bg = 'NONE' })

-- 2. TreeSitter Captures & LSP Semantic Tokens
-- Link everything to TanwiriUniformText instead of Normal
local tanwiri_links = {
    -- TreeSitter
    '@attribute', '@boolean', '@character', '@character.special',
    '@comment', '@conditional', '@constant', '@constant.builtin',
    '@constant.macro', '@constructor', '@error', '@exception',
    '@field', '@float', '@function', '@function.builtin',
    '@function.macro', '@include', '@keyword', '@keyword.function',
    '@keyword.operator', '@label', '@method', '@namespace',
    '@number', '@operator', '@parameter', '@parameter.reference',
    '@property', '@punctuation.delimiter', '@punctuation.bracket',
    '@punctuation.special', '@repeat', '@string', '@string.regex',
    '@string.escape', '@string.special', '@symbol', '@tag',
    '@tag.attribute', '@tag.delimiter', '@text', '@text.strong',
    '@text.emphasis', '@text.underline', '@text.strike',
    '@text.title', '@text.literal', '@text.uri', '@type',
    '@type.builtin', '@type.definition', '@type.qualifier',
    '@variable', '@variable.builtin',

    -- LSP Semantic Tokens
    '@lsp.type.class', '@lsp.type.comment', '@lsp.type.decorator',
    '@lsp.type.enum', '@lsp.type.enumMember', '@lsp.type.event',
    '@lsp.type.function', '@lsp.type.interface', '@lsp.type.keyword',
    '@lsp.type.macro', '@lsp.type.method', '@lsp.type.modifier',
    '@lsp.type.namespace', '@lsp.type.number', '@lsp.type.operator',
    '@lsp.type.parameter', '@lsp.type.property', '@lsp.type.regexp',
    '@lsp.type.string', '@lsp.type.struct', '@lsp.type.type',
    '@lsp.type.typeParameter', '@lsp.type.variable',
}

for _, group in ipairs(tanwiri_links) do
    hl(0, group, { link = 'TanwiriUniformText' })
end

-- 3. LSP Diagnostics
-- This removes color from errors/warnings but keeps underlines.
local diagnostics = {
    DiagnosticError = { fg = c.base_fg, bg = 'NONE' },
    DiagnosticWarn  = { fg = c.base_fg, bg = 'NONE' },
    DiagnosticInfo  = { fg = c.base_fg, bg = 'NONE' },
    DiagnosticHint  = { fg = c.base_fg, bg = 'NONE' },

    DiagnosticUnderlineError = { fg = c.base_fg, underline = true },
    DiagnosticUnderlineWarn  = { fg = c.base_fg, underline = true },
    DiagnosticUnderlineInfo  = { fg = c.base_fg, underline = true },
    DiagnosticUnderlineHint  = { fg = c.base_fg, underline = true },
}

set_hl(diagnostics)
