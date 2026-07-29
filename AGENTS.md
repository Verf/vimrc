# AGENTS.md

Personal Neovim configuration for Neovim 0.12.

## Directory Structure

```
nvim/
├── init.lua                  # Entry point, enables vim.loader, defines _G.MyGroup augroup
├── plugin/                   # Auto-loaded config (alphanumeric order)
│   ├── 10_options.lua        # Core options, Neovide, shell (nu), UI, diagnostics, grep
│   ├── 20_keymaps.lua        # Global keymaps
│   ├── 30_autocmds.lua       # Global autocommands (auto-save, terminal, etc.)
│   ├── 40_commands.lua       # Custom commands (:Grep)
│   ├── 50_lsp.lua            # LSP config (vim.lsp.config built-in API, no nvim-lspconfig)
│   ├── 80_mini/              # mini.nvim ecosystem (00–81)
│   └── 90_plugins/           # External plugins (10–62)
├── lua/plugins/              # Custom Lua modules
├── snippets/                 # mini.snippets snippets
├── after/ftplugin/           # Filetype-specific overrides
├── stylua.toml
└── nvim-pack-lock.json
```

## Loading System

### Plugin Manager
Built-in `vim.pack` (`:help vim.pack`). No lazy.nvim, no packer.

### Deferred Loading
Defined in `plugin/80_mini/00_mini.lua` via `mini.misc`:

| Helper | Trigger |
|--------|---------|
| `Config.now(f)` | Immediately at startup |
| `Config.later(f)` | After `UIEnter` |
| `Config.now_if_args(f)` | `now` if files on cmdline, else `later` |
| `Config.on_event(ev, f)` | On Neovim event |
| `Config.on_filetype(ft, f)` | On filetype match |

### Load Order
Files in `plugin/` load alphanumerically:
- `10_` Options → `20_` Keymaps → `30_` Autocommands → `40_` Commands → `50_` LSP
- `80_mini/` mini.nvim (00 must load first — defines `Config.*` and `_G.MyGroup`)
- `90_plugins/` External plugins

## Key Conventions

| Rule | Detail |
|------|--------|
| Leader | `<leader>` = `Space`, `<localleader>` = `,` |
| Indent | 4 spaces, no tabs; `stylua.toml` enforces |
| Quotes | Single quotes preferred |
| Comments | Chinese |
| Line endings | Unix (`\n`) |
| Shell | nushell (`nu`) when available, else default |
| Mouse | Enabled in all modes |
| Clipboard | `unnamedplus` (system clipboard) |

### Keymaps
- **Every keymap must have `desc`** (feeds which-key)
- `remap = false` (the default)
- Plugin keymaps set alongside plugin config, not in `20_keymaps.lua`
- `g` prefix maps use physical key positions (no remap)
- `w`/`e`/`b` remapped to custom subword motion (`lua/plugins/subword.lua`)

### Autocommands
- `plugin/` files → use `_G.MyGroup` (defined in `init.lua`, `clear = true`)
- `lua/plugins/` modules → use their own augroup

### Plugin Config Pattern
```lua
Config.now(function()
    require('plugin').setup { ... }
end)
```

## Plugin Inventory

### mini.nvim (`plugin/80_mini/`)

| File | Purpose |
|------|---------|
| `00_mini.lua` | Config helpers (`Config.now`/`later`/etc.) |
| `10_mini.icons.lua` | Icon provider + mock nvim-web-devicons |
| `11_mini.misc.lua` | `setup_auto_root`, `setup_restore_cursor` |
| `12_mini.keymap.lua` | Keymap explorer |
| `20_mini.hipatterns.lua` | Highlight TODO/FIXME/hex colors |
| `21_mini.trailspace.lua` | Trailing whitespace highlight |
| `30_mini.ai.lua` | Text objects (+ treesitter class/function) |
| `31_mini.comment.lua` | Comment toggle |
| `32_mini.pairs.lua` | Auto-pairs |
| `33_mini.surround.lua` | Surround (ma/md/mc) |
| `34_mini.align.lua` | Text alignment |
| `35_mini.splitjoin.lua` | Split/join |
| `36_mini.operators.lua` | Sort/replace operators |
| `37_mini.move.lua` | Move lines (M-arrows) |
| `40_mini.jump.lua` | Jump labels (f/F/t/T) |
| `41_mini.jump2d.lua` | 2D jump (gw/gs/gl/,) |
| `50_mini.diff.lua` | Diff overlay (number column) |
| `51_mini.git.lua` | Git integration |
| `52_mini.bufremove.lua` | Buffer delete (<leader>x) |
| `53_mini.sessions.lua` | Session management |
| `54_mini.visits.lua` | Visit tracking |
| `55_mini.cmdline.lua` | Enhanced cmdline |
| `60_mini.completion.lua` | LSP completion (2-stage, fallback `<C-n>`) |
| `61_mini.snippets.lua` | Snippet engine |
| `70_mini.pick.lua` | Fuzzy picker (<leader>f/<leader>b) |
| `71_mini.extra.lua` | Extra pickers (oldfiles, LSP, git, etc.) |
| `80_mini.statusline.lua` | Statusline |
| `81_mini.tabline.lua` | Tabline |

### External Plugins (`plugin/90_plugins/`)

| File | Plugin | Purpose |
|------|--------|---------|
| `10_deepwhite.lua` | deepwhite.nvim | Colorscheme |
| `11_faster.lua` | custom → `lua/plugins/faster.lua` | Big-file/long-line/macro perf degrade |
| `12_scrollEOF.lua` | custom → `lua/plugins/scroll_eof.lua` | Scroll beyond EOF |
| `13_scope.lua` | custom → `lua/plugins/tab_scope.lua` | Tab-isolated buffer listing |
| `15_flatten.lua` | flatten.nvim | Open external files in current Neovim |
| `20_treesitter.lua` | nvim-treesitter | Parser install + textobjects |
| `22_spider.lua` | custom → `lua/plugins/subword.lua` | CamelCase/subword w/e/b |
| `23_multicursor.lua` | multicursor.nvim | Multi-cursor editing |
| `40_whichkey.lua` | which-key.nvim | Keymap hints |
| `41_oil.lua` | oil.nvim | File explorer (`-`) |
| `50_conform.lua` | conform.nvim | Formatting (ruff, stylua, prettier, etc.) |
| `51_quicker.lua` | custom → `lua/plugins/quickfix.lua` | Quickfix expand/collapse/toggle |
| `52_codediff.lua` | codediff.nvim | Code diff tools |
| `54_render_markdown.lua` | render-markdown.nvim | Markdown preview |
| `60_fold.lua` | custom → `lua/plugins/fold.lua` | Treesitter foldtext + foldcolumn icons |
| `61_gtd.lua` | custom → `lua/plugins/gtd.lua` | GTD task manager |
| `62_path_lsp.lua` | custom → `lua/plugins/path_lsp.lua` | In-process file path completion LSP |

### Custom Modules (`lua/plugins/`)

| Module | Replaces | Key features |
|--------|----------|--------------|
| `faster.lua` | pteroctopus/faster.nvim | >2 MiB or >250 B/line → disable treesitter/LSP/syntax; macro → `eventignore=all` |
| `subword.lua` | chrisgrieser/nvim-spider | w/e/b with `vim.v.count1`; operator-pending mode |
| `tab_scope.lua` | tiagovla/scope.nvim | TabLeave unlist / TabEnter restore |
| `quickfix.lua` | stevearc/quicker.nvim | expand/collapse context; quickfixtextfunc |
| `fold.lua` | — | TS-highlighted foldtext + foldcolumn icons; per-buffer cache |
| `scroll_eof.lua` | — | Scroll beyond last line |
| `path_lsp.lua` | — | Function-transport LSP for file path completion |
| `gtd.lua` | — | `# TODO`/`# DONE` task manager; DEADLINE/CLOSED tags |

### LSP Servers
Configured in `50_lsp.lua` via `vim.lsp.config()` (Neovim built-in API):
- `ruff` — Python lint + organize imports
- `ty` — Python type checker
- `nushell` — Nu IDE support
- `vls` — Vue 2 (Vetur, Node ≤16)

## Workflow

### Making Changes
1. Edit the relevant file(s) — see inventory above for which file controls what
2. Run `stylua` on changed Lua files (or rely on conform.nvim's auto-format)
3. **After every change, auto-commit**:

```bash
git add -A
git commit -m "<scope>: <brief description>"
```

Use conventional commit scopes matching the area changed:
- `options`, `keymaps`, `autocmds`, `commands`, `lsp`
- `mini.<name>` (e.g., `mini.pick`, `mini.statusline`)
- `plugins.<name>` (e.g., `plugins.faster`, `plugins.gtd`)
- `perf` for performance-only changes
- `audit` for audit/cleanup work

Examples:
```
git commit -m "mini.pick: use git ls-files to bypass security software I/O hooks"
git commit -m "perf: remove BufEnter from path_lsp autocmd to reduce trigger frequency"
git commit -m "audit: remove deprecated shapeim references"
```

### Do Not
- ❌ **Do NOT** introduce `lazy.nvim`, `packer`, or any alternative plugin manager
- ❌ **Do NOT** create autocommands in `plugin/` without `group = _G.MyGroup`
- ❌ **Do NOT** add keymaps without a `desc` field
- ❌ **Do NOT** use `2>nul` in shell commands — use `2>/dev/null` (this runs under msys2 bash)
- ❌ **Do NOT** add plugins that conflict with existing mini.nvim modules
- ❌ **Do NOT** change shell config (nushell) without understanding implications
- ❌ **Do NOT** forget to update this file when adding/removing plugins
