# AGENTS.md

## Project Overview

Personal Neovim configuration for Neovim 0.12.

## Directory Structure

```
nvim/
├── init.lua                  # Entry point: enables vim.loader, defines global Config
├── plugin/                   # All config files (auto-loaded by Neovim)
│   ├── 10_options.lua        # Core options, Neovide, shell (nu), UI, diagnostics, grep, fold (treesitter expr)
│   ├── 20_keymaps.lua        # All keymaps, Norman keyboard layout remaps
│   ├── 30_autocmds.lua       # Autocommands: auto-save, terminal behavior, etc.
│   ├── 40_commands.lua       # Custom commands (e.g., :Grep)
│   ├── 50_lsp.lua            # LSP config (built-in vim.lsp.config API)
│   ├── 80_mini/              # mini.nvim ecosystem plugins
│   └── 90_plugins/           # External plugins
├── lua/
│   └── plugins/
│       ├── gtd.lua           # Custom GTD task management plugin
│       └── path_lsp.lua      # In-process path completion LSP (function transport)
├── snippets/                 # Custom snippets (mini.snippets format)
├── stylua.toml               # Lua formatter config
├── nvim-pack-lock.json       # Plugin version lock (generated)
├── README.md
└── AGENTS.md                 # This file
```

## Plugin Loading System

### Plugin Management

Plugins are organized by neovim builtin plugin manager `:help vim.pack`

### Deferred Loading (Config.now / Config.later / Config.on_event)

Global helpers are defined in `plugin/80_mini/00_mini.lua` using `mini.misc`:

| Helper | Behavior |
|--------|----------|
| `Config.now(f)` | Execute immediately at startup |
| `Config.later(f)` | Defer to after UIEnter (for non-critical plugins) |
| `Config.now_if_args(f)` | `now` if files passed on cmdline, else `later` |
| `Config.on_event(event, f)` | Execute on Neovim event (e.g., `InsertEnter`) |
| `Config.on_filetype(ft, f)` | Execute on filetype match |

Usage in plugin files:
```lua
Config.now(function()
    require('some-plugin').setup { ... }
end)
```

### Load Order (Numbered Prefixes)

Files in `plugin/` load in alphanumeric order:
- `10_` — Core options (must load first)
- `20_` — Keymaps
- `30_` — Autocommands
- `40_` — User commands
- `50_` — LSP config (built-in API, no external dependency)
- `80_mini/` — mini.nvim plugins (80–81)
- `90_plugins/` — External plugins (10–60+)

Sub-files use the same scheme: `20_mini.hipatterns.lua`, `20_treesitter.lua`, etc.

### Key Dependencies

- `00_mini.lua` must load before all other plugins — it defines `Config.*` helpers and the `_G.MyGroup` augroup used by other files
- Plugin config files are standalone; they all receive `Config.*` from `00_mini.lua`

## Key Configuration Conventions

### General
- **Leader key**: Space (`<leader>` = `' '`), LocalLeader = `','`
- **Indentation**: 4 spaces (never tabs)
- **Quote style**: Single quotes preferred (`stylua.toml`)
- **Comments**: Chinese throughout (keep Chinese when adding comments)
- **Line endings**: Unix (`\n`)
- **Mouse**: Enabled in all modes
- **cmdheight**: 0 (hidden, uses Neovim's experimental UI2 for messages)
- **Shell**: nushell when available, else falls back to default

### Keymap Rules
- **All keymaps must have `desc`** — this feeds which-key.nvim
- Using Norman keyboard layout, `plugin/20_keymaps.lua` remap all normal mode key to remain the same position as qwerty layout.
- remap is always `false` (the default in vim.keymap.set)
- Which-key groups defined in `plugin/90_plugins/40_whichkey.lua`

### Autocommands
- `plugin/` 配置文件中的 autocommand 统一使用 `_G.MyGroup`（在 `init.lua` 中定义）
- `lua/plugins/` 模块中的 autocommand 使用自己的 augroup，不依赖 `_G.MyGroup`
- Group is cleared on reload (`clear = true`)

### Plugin Config Style
- Plugin setup functions wrapped in `Config.now()` / `Config.later()` / etc.
- Keymaps for a plugin are set in the same file as its config
- Prefer `require('plugin').setup {}` pattern
- `plugin/` 中的 autocommand 必须使用 `_G.MyGroup`；`lua/plugins/` 模块使用自己的 augroup

## Norman Keyboard Layout

This config uses a custom Norman-inspired keymap that remaps the home row. **All keymaps throughout the codebase assume these remaps are active.**

| Physical Key | Logical Vim Key | Effect |
|-------------|-----------------|--------|
| `d` | `e` | end of word |
| `f` | `r` | replace |
| `k` | `t` | till |
| `j` | `y` | yank |
| `r` | `i` | insert |
| `l` | `o` | open below |
| `e` | `d` | delete |
| `t` | `f` | find |
| `y` | `h` | left |
| `n` | `j` | down |
| `i` | `k` | up |
| `o` | `l` | right |
| `p` | `n` | next |
| `h` | `;` | repeat f/t |
| `;` | `p` | paste |

**When adding new keymaps**, use the physical key positions (Norman layer). For example, `<leader>j` does system copy because `j` → `y` (yank). Motion keys `w`, `d` (→`e`), `b` are remapped through custom subword (`lua/plugins/subword.lua`).

## Plugin Catalog

### mini.nvim (`plugin/80_mini/`)
| File | Plugin | Purpose |
|------|--------|---------|
| `00_mini.lua` | mini.misc | Core loading helpers |
| `10_mini.icons.lua` | mini.icons | Icon provider |
| `11_mini.misc.lua` | mini.misc | Misc utilities |
| `20_mini.hipatterns.lua` | mini.hipatterns | Highlight patterns |
| `21_mini.trailspace.lua` | mini.trailspace | Trailing whitespace |
| `30_mini.ai.lua` | mini.ai | Text objects |
| `31_mini.comment.lua` | mini.comment | Comment toggle |
| `32_mini.pairs.lua` | mini.pairs | Auto-pairs |
| `33_mini.surround.lua` | mini.surround | Surround actions |
| `34_mini.align.lua` | mini.align | Text alignment |
| `35_mini.splitjoin.lua` | mini.splitjoin | Split/join |
| `36_mini.operators.lua` | mini.operators | Text operators |
| `37_mini.move.lua` | mini.move | Move lines |
| `40_mini.jump.lua` | mini.jump | Jump labels |
| `41_mini.jump2d.lua` | mini.jump2d | 2D jump labels |
| `50_mini.diff.lua` | mini.diff | Diff overlay |
| `51_mini.git.lua` | mini.git | Git integration |
| `52_mini.bufremove.lua` | mini.bufremove | Buffer removal |
| `53_mini.sessions.lua` | mini.sessions | Session management |
| `54_mini.visits.lua` | mini.visits | Visit tracking |
| `55_mini.cmdline.lua` | mini.cmdline | Enhanced cmdline |
| `60_mini.snippets.lua` | mini.snippets | Snippet engine |
| `61_mini.keymap.lua` | mini.keymap | Keymap explorer |
| `70_mini.pick.lua` | mini.pick | Fuzzy picker |
| `71_mini.extra.lua` | mini.extra | Extra pickers |
| `80_mini.statusline.lua` | mini.statusline | Statusline |
| `81_mini.tabline.lua` | mini.tabline | Tabline |

### External Plugins (`plugin/90_plugins/`)
| File | Plugin | Purpose |
|------|--------|---------|
| `10_deepwhite.lua` | deepwhite.nvim | Colorscheme |
| `11_faster.lua` | (custom faster) | Big-file/long-line/macro perf (see lua/plugins/faster.lua) |
| `12_scrollEOF.lua` | scrollEOF | Scroll beyond EOF |
| `13_scope.lua` | (custom tab_scope) | Tab-scoped buffer listing (see lua/plugins/tab_scope.lua) |
| `14_shapeim.lua` | shapeim.nvim | Input method (Rime) integration |
| `15_flatten.lua` | flatten.nvim | Open files from :term in current Neovim instance |
| `20_treesitter.lua` | arborist.nvim | Manage tree-sitter parsers and queries |

| `22_spider.lua` | (custom subword) | CamelCase/subword motion (see lua/plugins/subword.lua) |
| `23_multicursor.lua` | multicursor.nvim | Multi-cursor editing |
| `30_blink.lua` | blink.cmp | Completion engine (uses mini_snippets preset) |
| `40_whichkey.lua` | which-key.nvim | Keymap hints |
| `41_oil.lua` | oil.nvim | File explorer/buffer |
| `50_conform.lua` | conform.nvim | Formatting (ruff, stylua, nufmt, oxfmt, etc.) |
| `51_quicker.lua` | (custom quickfix) | Quickfix context expand/collapse (see lua/plugins/quickfix.lua) |
| `52_codediff.lua` | codediff | Code diff tools |
| `54_render_markdown.lua` | render-markdown.nvim | Markdown preview |
| `55_path_lsp.lua` | (custom) path-lsp | In-process filesystem path completion LSP — 命名 buffer 按 root_dir 共享 client，未命名 buffer 独立 client + BufWipeout 自清理 |
| `60_gtd.lua` | (custom GTD) | Loads `lua/plugins/gtd.lua` — personal task manager |

### Custom Plugin: Faster (`lua/plugins/faster.lua`)

Replaces the external `pteroctopus/faster.nvim` plugin. Self-contained performance module that:
- **Bigfile**: On `BufReadPost`, if file > 2 MiB, disables treesitter/LSP/syntax/filetype/vimopts/matchparen
- **Longline**: If `filesize/line_count > 250` bytes/line (minified JS/JSON), same feature disable
- **Macro**: Overrides `@` keymap — sets `eventignore='all'` + `lazyredraw=true` during macro execution, restores on completion
- Features use backup/restore per-buffer; macros use sentinel feedkeys + poll backstop

### Custom Plugin: Subword (`lua/plugins/subword.lua`)

Replaces the external `chrisgrieser/nvim-spider` plugin. Self-contained camelCase/snake_case subword motion:
- **Patterns**: numbers (`%d+`), camelCase words (`%u?%l+`/`%l+%u?`), UPPER_CASE words, single uppercase with frontier
- **Punctuation**: skips insignificant punctuation (spaces around punctuation marks)
- **Motions**: `w` (next subword start), `e` (next subword end), `b` (previous subword start)
- Supports `vim.v.count1` for count-prefixed jumps (e.g., `3w`)
- Handles operator-pending mode (inclusive for `e`, column correction for end-of-line)

### Custom Plugin: Tab Scope (`lua/plugins/tab_scope.lua`)

Replaces the external `tiagovla/scope.nvim` plugin. Tab-isolated buffer listing:
- **TabLeave**: saves current tab's listed buffers to cache, unlists them
- **TabEnter**: restores target tab's cached buffers as listed
- **TabClosed**: clears cache for the closed tab
- Ensures each tab only shows its own buffers in `:ls`/`:buffers`

### Custom Plugin: Quickfix (`lua/plugins/quickfix.lua`)

Replaces the external `stevearc/quicker.nvim` plugin. Quickfix context expand/collapse:
- **expand()**: Surrounds each quickfix entry with configurable before/after context lines
- **collapse()**: Strips context lines, keeping only valid items
- **toggle()**: Open/close quickfix window
- **quickfixtextfunc**: File path + line number + source line display
- Overlapping context between adjacent items in the same file is deduplicated
- Expand state (before/after counts) stored in quickfix context for incremental expansion

### Custom Plugin: GTD (`lua/plugins/gtd.lua`)

A self-contained task management plugin. Key conventions:
- **File format**: Markdown files named `todo.md` with `# TODO` / `# DONE` headers
- **Metadata tags**: `DEADLINE:<YYYY-MM-DD>` and `CLOSED:<YYYY-MM-DD HH:MM:SS>`
- **Setup**: Requires `todo_dir` (typically `$NOTE_TAKING_DIR`)
- **Commands**: `:GTDList` (populate quickfix), `:GTDToggle` (toggle TODO↔DONE)
- **Lazy-init**: Configuration in `plugin/90_plugins/60_gtd.lua`, module in `lua/plugins/gtd.lua`

### LSP Servers
Configured via `vim.lsp.config()` in `50_lsp.lua` (Neovim 0.11+ built-in API, no nvim-lspconfig dependency):
- `ruff` — Python linter + organize imports (`ruff server`)
- `ty` — Python type checker
- `nushell` — Nushell IDE support
- `vls` — Vue2 language server (Vetur, Node ≤16)

## Coding Guidelines

### When Adding a New Plugin
1. Create a file in `plugin/80_mini/` (mini.nvim) or `plugin/90_plugins/` (external)
2. Pick the next available number prefix following the existing scheme
3. Use `vim.pack.add {}` at the top
4. Wrap setup in `Config.now()` / `Config.later()` / `Config.on_event()` as appropriate
5. Set keymaps in the same file, always with `desc`
6. If it needs a custom Lua module, place it in `lua/plugins/`
7. Update the `AGENTS.md`.

### When Modifying Existing Config
- **Keymaps**: Edit `20_keymaps.lua` for global keymaps, or the plugin file for plugin-specific ones
- **Options**: Edit `10_options.lua`
- **Autocommands**: Edit `30_autocmds.lua`（全局）, always use `_G.MyGroup`；`lua/plugins/*.lua` 模块使用各自 augroup
- **Commands**: Edit `40_commands.lua`
- **Formatting**: Run `stylua` on any changed Lua files (or rely on conform.nvim)
- **Finally** Update the `AGENTS.md`.

### Do Not
- Do NOT introduce `lazy.nvim`, `packer`, or any alternative plugin manager — stick with `vim.pack`
- Do NOT create autocommands in `plugin/` without `group = _G.MyGroup`；`lua/plugins/` 使用自己的 augroup
- Do NOT add keymaps without a `desc` field
- Do NOT change the Norman keyboard layout remaps in `20_keymaps.lua` — they are intentional and affect all other keymaps
- Do NOT change the shell config (nushell) without understanding the implications
- Do NOT add plugins that conflict with existing mini.nvim modules
- Do NOT use `2>nul` in shell commands — this project runs under msys2 bash, where `2>nul` creates a junk file named `nul` (a Windows reserved device name, hard to delete). Use `2>/dev/null` instead.

## File-Issue Mapping

When a user reports an issue, start investigation here:
- **Startup/performance**: `init.lua`, `10_options.lua` (shada settings), `11_faster.lua`
- **Keymaps not working**: `20_keymaps.lua` (Norman remaps), plugin files (plugin-specific maps), `22_spider.lua` + `lua/plugins/subword.lua` (subword motions)
- **Completion**: `30_blink.lua`
- **LSP/formatting/diagnostics**: `50_lsp.lua`, `50_conform.lua`, `10_options.lua` (diagnostic config)
- **Folding**: `10_options.lua` (foldmethod=expr via treesitter, foldminlines=2, foldnestmax=4, custom foldtext with treesitter highlighting + right-aligned line count `󰈉 N lines`, per-buffer cache invalidated on text change)
- **Colors/appearance**: `10_deepwhite.lua`, `80_mini.statusline.lua`, `81_mini.tabline.lua`, `10_options.lua` (UI options)
- **File operations/sessions**: `53_mini.sessions.lua`, `54_mini.visits.lua`, `41_oil.lua`, `13_scope.lua` + `lua/plugins/tab_scope.lua` (tab buffer isolation)
- **Input method**: `14_shapeim.lua` (Rime toggle/config)
- **GTD/tasks**: `60_gtd.lua` + `lua/plugins/gtd.lua`
- **Path completion**: `55_path_lsp.lua` + `lua/plugins/path_lsp.lua`
- **Quickfix**: `51_quicker.lua` + `lua/plugins/quickfix.lua`, `40_commands.lua` (`:Grep`), `30_autocmds.lua` (auto-open)
- **Terminal**: `30_autocmds.lua` (TermOpen/TermClose), `20_keymaps.lua` (terminal keymaps)
