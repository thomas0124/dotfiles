# dotfiles

thomas0124 の macOS 開発環境設定。[chezmoi](https://www.chezmoi.io/) で管理。

## 構成

| カテゴリ | ツール |
|---|---|
| ターミナル | [WezTerm](https://wezfurlong.org/wezterm/) |
| シェル | zsh + [sheldon](https://sheldon.cli.rs/) + [starship](https://starship.rs/) |
| エディタ | [Neovim](https://neovim.io/) |
| マルチプレクサ | [tmux](https://github.com/tmux/tmux) |
| ウィンドウマネージャ | [AeroSpace](https://github.com/nikitabobko/AeroSpace) |
| ステータスバー | [SketchyBar](https://github.com/FelixKratz/SketchyBar) |
| Git UI | [lazygit](https://github.com/jesseduffield/lazygit) / [gitui](https://github.com/extrawurst/gitui) |
| リポジトリ管理 | [ghq](https://github.com/x-motemen/ghq) |
| バージョン管理 | [mise](https://mise.jdx.dev/) / [goenv](https://github.com/go-nv/goenv) / [rbenv](https://github.com/rbenv/rbenv) |
| コマンド強化 | [fzf](https://github.com/junegunn/fzf) / [zoxide](https://github.com/ajeetdsouza/zoxide) / [atuin](https://github.com/atuinsh/atuin) / [bat](https://github.com/sharkdp/bat) / [eza](https://github.com/eza-community/eza) |

---

## セットアップ

### 1. Homebrew のインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. chezmoi のインストールとリポジトリの適用

```bash
brew install chezmoi

chezmoi init --apply thomas0124
```

> `chezmoi init` は `~/.local/share/chezmoi` にリポジトリをクローンし、`--apply` で即座に設定ファイルを展開します。

### 3. 主要ツールのインストール

```bash
brew install \
  sheldon starship tmux \
  neovim lazygit gitui \
  ghq fzf zoxide atuin \
  bat eza peco mise \
  sketchybar borders \
  aerospace wezterm
```

WezTerm は [公式サイト](https://wezfurlong.org/wezterm/installation.html) からもインストールできますが、`brew install wezterm` が簡単です。

### 4. シェルの再起動

```bash
exec zsh
```

---

## chezmoi の使い方

### 設定ファイルの編集

```bash
# chezmoi のソースディレクトリでファイルを編集
chezmoi edit ~/.config/zsh/.zshrc

# 編集内容をホームディレクトリに適用
chezmoi apply
```

### 変更の確認

```bash
# ソースとホームの差分を確認
chezmoi diff

# 適用前に変更内容をプレビュー
chezmoi apply --dry-run
```

### ファイルの追加

```bash
# 既存のファイルを chezmoi の管理下に追加
chezmoi add ~/.config/some/config

# ソースディレクトリに移動して git 管理
chezmoi cd
git add .
git commit -m "feat: add some config"
git push
```

### 別マシンへの適用

```bash
# 初回
chezmoi init --apply thomas0124

# 既に init 済みの場合は update
chezmoi update
```

---

## ディレクトリ構造

chezmoi では `dot_` プレフィックスが `.` に変換されます。

```
dotfiles/
└── dot_config/          →  ~/.config/
    ├── aerospace/       →  AeroSpace 設定
    ├── atuin/           →  履歴検索
    ├── ghostty/         →  ターミナル設定
    ├── lazygit/         →  Git TUI 設定
    ├── mise/            →  ランタイムバージョン管理
    ├── nvim/            →  Neovim 設定
    ├── sheldon/         →  zsh プラグイン管理
    ├── sketchybar/      →  メニューバー設定
    ├── starship.toml    →  プロンプト設定
    ├── wezterm/         →  WezTerm 設定 (旧)
    └── zsh/             →  zsh 設定
```

---

## zsh ショートカット

| キー | 動作 |
|---|---|
| `Ctrl+r` | peco でコマンド履歴検索 |
| `Ctrl+q` | fzf + zoxide でディレクトリ移動 |
| `Ctrl+b` | fzf で git ブランチ選択 |

### カスタム関数

| コマンド | 説明 |
|---|---|
| `ghfd` | ghq リポジトリを fzf で検索して移動 |
| `fd` | カレント配下のディレクトリを fzf で移動 |
| `fdgit` | git リポジトリ内のディレクトリを fzf で移動 |
| `ghi` | GitHub Issue を fzf で検索してブラウザで開く |
| `ghcl <repo>` | `ghq get` でリポジトリをクローンして移動 |
| `ghcr <repo>` | GitHub にリポジトリを作成してクローンして移動 |

---

## tmux キーバインド (Zellij スタイル)

モードキーを押すとステータスバーにヘルプが表示されます。

| モード起動 | 内容 |
|---|---|
| `Ctrl+p` | Pane モード（分割・移動・フォーカス） |
| `Ctrl+t` | Tab モード（ウィンドウ作成・切替） |
| `Ctrl+n` | Resize モード（ペインサイズ変更） |
| `Ctrl+h` | Move モード（ペイン移動） |
| `Ctrl+o` | Session モード（セッション管理） |
| `Ctrl+s` | コピーモード + 検索 |

各モードは `Escape` / `Enter` / `q` で抜けます。

---

## WezTerm 設定

- フォント: HackGen Console NF (17px)
- 背景透過: 70% + macOS ブラーあり
- リーダーキー: `Ctrl+a`
- タブバー右側にアクティブな MODE と WORKSPACE 名を表示
- デフォルトキーバインドは無効化し `keybinds.lua` で独自定義
