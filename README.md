# Theme-Picker

Ein CLI-Themesystem fuer macOS (Terminal/iTerm/Ghostty/tmux) mit optionaler
Synchronisation auf einen Linux-Server. Verwaltet abgestimmte Konfigs fuer
**starship**, **tmux**, **fzf** und **bat** anhand von 50 vorgenerierten Themes.

## Installation

```bash
git clone https://github.com/dev-roeber/CLI-theme-picker.git
cd CLI-theme-picker
./install.sh
```

Erforderliche Tools (vorher installieren, z.B. via Homebrew / Linuxbrew /
`apt`): `starship fzf bat tmux git curl jq rsync`.

Nach der Installation liegen die Dateien unter:

- `~/.config/theme-picker/bin/`      — Skripte
- `~/.config/theme-picker/themes/`   — 50 Theme-Ordner (`01-…` bis `50-…`)
- `~/.config/theme-picker/state/`    — aktueller Theme-Slug
- `~/.config/theme-picker/backups/`  — Backups pro Apply
- `~/.local/bin/`                    — Symlinks fuer `$PATH`

Optional fuer Server-Sync (Hetzner, VPS, ...):

```bash
export THEME_PICKER_SSH_HOST=user@server.example.com
```

(Am besten in `~/.zshrc` / `~/.bashrc` setzen.)

## Befehle

| Befehl                 | Beschreibung                                                       |
|------------------------|--------------------------------------------------------------------|
| `theme-picker`         | Interaktive Auswahl (fzf) mit Preview; fragt local/server/all      |
| `theme-list`           | Tabellenuebersicht aller 50 Themes, Marker `*` beim aktiven        |
| `theme-current`        | Gibt den aktuell aktiven Theme-Slug aus                            |
| `theme-apply SLUG`     | Wendet Theme lokal an (Backup + Symlinks + zshrc-Marker)           |
| `theme-sync-server S`  | rsync auf `$THEME_PICKER_SSH_HOST (user)`, installiert Tools + apply     |
| `theme-rollback [TS]`  | Stellt juengsten (oder benannten) Backup-Ordner wieder her         |
| `theme-generate-all`   | Stub: prueft Vollstaendigkeit der 50 Theme-Ordner (`--check`)       |

`theme-picker` Optionen: `--local`, `--server`, `--all`, `--theme SLUG`, `--list`, `-h|--help`.

## Themes

Es gibt **50 Themes**. Liste mit Rang, Kategorie, Nerd-Font-Bedarf und
Empfehlung siehe `theme-list`.

Kategorien:

- `official-preset`      — von starship/dracula offiziell gepflegt
- `external-verified`    — kuratiert aus externen Quellen
- `local-generated`      — lokal erstellte Varianten

## MacBook-Verwendung

Default-Empfehlung: **`01-catppuccin-mocha`** (mit Nerd Font). Wendet sich
sauber auf Apple Terminal, iTerm2 und Ghostty an. Voraussetzung fuer die
Glyph-Themes ist eine installierte Nerd Font (siehe unten).

```sh
theme-picker --theme 01-catppuccin-mocha --local
```

## Server-Verwendung

Server: `$THEME_PICKER_SSH_HOST (user)` (Linuxbrew). Keine GUI, keine Fonts.
Default-Empfehlung: **`03-tokyo-night`** (Farbe ohne Nerd-Glyphen).

```sh
theme-picker --theme 03-tokyo-night --server
```

`theme-sync-server` installiert fehlende Tools (`starship fzf bat tmux git curl jq rsync`)
via Linuxbrew, legt Symlinks unter `~/.local/bin/` und ruft remote
`theme-apply` auf.

## iPhone / Shellfish-Empfehlung

Shellfish hat keine Nerd-Font-Unterstuetzung, daher Plain-Text-Themes:

- `15-no-nerd-fonts`
- `08-pure-prompt`
- `19-plain-text-symbols`
- `49-crampack-plain-text`

## Nerd Fonts

Lokal optional:

```sh
brew install --cask font-jetbrains-mono-nerd-font
```

Auf dem Server werden bewusst **keine Fonts** installiert (Headless).
Themes mit `nerd_font_required: true` deshalb nur lokal verwenden.

## Rollback

`theme-rollback` ohne Argument stellt den juengsten Backup-Ordner aus
`~/.config/theme-picker/backups/` wieder her. Vor dem Restore wird der
aktuelle Zustand als `pre-rollback-YYYYMMDD-HHMMSS/` gesichert.

```sh
theme-rollback                  # juengstes Backup
theme-rollback 20260513-101530  # bestimmtes Backup
```

Hinweis: das `state/current-theme`-File wird beim Rollback **nicht**
geaendert; ein Mismatch zu den tatsaechlich aktiven Configs wird gemeldet.

## Backup-Schema

Jeder `theme-apply`-Aufruf legt einen Ordner an:

```
~/.config/theme-picker/backups/YYYYMMDD-HHMMSS/
  starship.toml
  tmux.conf
  tmux-theme.conf
  fzf-theme.zsh
  bat-config
  zshrc
  .applied-from   # Theme-Slug, der angewendet wurde
```

Bestehende Symlinks, die bereits in `~/.config/theme-picker/` zeigen,
werden nicht erneut gesichert.

## Pfade

| Pfad                                            | Inhalt                              |
|-------------------------------------------------|-------------------------------------|
| `~/.config/theme-picker/bin/`                   | Skripte                             |
| `~/.config/theme-picker/themes/NN-slug/`        | starship.toml, tmux.conf, fzf.zsh, bat.conf, theme.env, metadata.json |
| `~/.config/theme-picker/state/current-theme`    | aktueller Theme-Slug                |
| `~/.config/theme-picker/backups/`               | Backups pro Apply                   |
| `~/.config/theme-picker/current-theme.zsh`      | wird aus `~/.zshrc` gesourct        |
| `~/.local/bin/theme-*`                          | Symlinks der Skripte                |
| `~/.config/starship.toml`                       | Symlink → aktiver Theme             |
| `~/.config/tmux/theme.conf`                     | Symlink → aktiver Theme             |
| `~/.config/fzf/theme.zsh`                       | Symlink → aktiver Theme             |
| `~/.config/bat/config`                          | Symlink → aktiver Theme             |
