# Developer Setup Cheat Sheet

## Ghostty

| Action              | Keys                        |
|---------------------|-----------------------------|
| Toggle fullscreen   | `Cmd+Enter` or `Cmd+Ctrl+f` |
| New window          | `Cmd+n`                     |
| New tab             | `Cmd+t`                     |
| Reload config       | `Cmd+Shift+,`               |

Launches fullscreen with non-native mode. Config at `~/Library/Application Support/com.mitchellh.ghostty/config`.

---

## tmux

Prefix key: `Ctrl+Space` (press and release, then press the action key)
Backup prefix: `Ctrl+b`

Auto-starts with Ghostty. Sessions auto-save and auto-restore (resurrect + continuum).
Status bar at the top, Catppuccin Mocha theme.

### Sessions

| Action              | Keys                                  |
|---------------------|---------------------------------------|
| New session         | `Ctrl+Space C`                        |
| Detach              | `Ctrl+Space d`                        |
| Kill session        | `Ctrl+Space K`                        |
| Next session        | `Ctrl+Space N` or `Alt+Down`          |
| Previous session    | `Ctrl+Space P` or `Alt+Up`            |
| Rename session      | `Ctrl+Space R`                        |
| List sessions       | `tmux ls`                             |
| Reattach            | `tmux a` or `tmux a -t name`          |
| Full restart        | `tmux kill-server && tmux`            |

`detach-on-destroy off` -- closing last window switches to another session instead of detaching.

### Windows (tabs)

| Action              | Keys                                  |
|---------------------|---------------------------------------|
| New window          | `Ctrl+Space c`                        |
| Jump to window 1-9  | `Alt+1` through `Alt+9`              |
| Next window         | `Ctrl+Space n` or `Alt+Right`         |
| Previous window     | `Ctrl+Space p` or `Alt+Left`          |
| Move window left    | `Alt+Shift+Left`                      |
| Move window right   | `Alt+Shift+Right`                     |
| Rename window       | `Ctrl+Space r`                        |
| Kill window         | `Ctrl+Space k`                        |

### Panes

| Action              | Keys                                  |
|---------------------|---------------------------------------|
| Split right         | `Ctrl+Space \|`                       |
| Split down          | `Ctrl+Space -`                        |
| Navigate (vim)      | `Ctrl+Space h/j/k/l`                 |
| Navigate (arrows)   | `Ctrl+Alt+Arrow`                      |
| Resize (prefix)     | `Ctrl+Space H/J/K/L` (repeatable)    |
| Resize (no prefix)  | `Ctrl+Alt+Shift+Arrow`                |
| Zoom (fullscreen)   | `Ctrl+Space z`                        |
| Kill pane           | `Ctrl+Space x`                        |

### Copy Mode (vim-style)

| Action              | Keys                                  |
|---------------------|---------------------------------------|
| Enter copy mode     | `Ctrl+Space [`                        |
| Scroll up/down      | `k` / `j`                             |
| Start selection     | `v`                                   |
| Copy + exit         | `y` (copies to macOS clipboard)       |
| Page up/down        | `Ctrl+b` / `Ctrl+f`                  |
| Mouse drag          | Copies to clipboard                   |

### Misc

| Action              | Keys                                  |
|---------------------|---------------------------------------|
| Reload config       | `Ctrl+Space q`                        |
| Command prompt      | `Ctrl+Space :`                        |

---

## Dev Layouts (shell functions)

| Action                          | Command                     |
|---------------------------------|-----------------------------|
| Dev layout (editor + AI + term) | `tdl <ai_cmd>`              |
| Dev layout with 2 AIs           | `tdl <ai_cmd> <ai2_cmd>`   |
| Dev layout per subdirectory     | `tdlm <ai_cmd>`            |
| Swarm: N panes same command     | `tsl <count> <command>`     |

```
tdl claude:                 tsl 4 claude:
┌──────────┬─────┐          ┌─────┬─────┐
│          │     │          │     │     │
│  nvim    │ AI  │          │  1  │  2  │
│          │     │          │     │     │
├──────────┴─────┤          ├─────┼─────┤
│   terminal     │          │     │     │
└────────────────┘          │  3  │  4  │
                            │     │     │
                            └─────┴─────┘
```

---

## fzf (in shell)

| Action                    | Keys      |
|---------------------------|-----------|
| Fuzzy search history      | `Ctrl+r`  |
| Fuzzy find files          | `Ctrl+t`  |
| Fuzzy cd into directory   | `Alt+c`   |
