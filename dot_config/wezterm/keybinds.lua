local wezterm = require("wezterm")
local act = wezterm.action

-- key_tables名を表示
wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  if name then
    name = "TABLE: " .. name
  end
  window:set_right_status(name or "")
end)

return {
  keys = {
    {
      -- workspaceの切り替え
      key = "w",
      mods = "LEADER",
      action = wezterm.action_callback(function(win, pane)
        local workspaces = {}
        for i, name in ipairs(wezterm.mux.get_workspace_names()) do
          table.insert(workspaces, {
            id = name,
            label = name,
          })
        end
        local current = wezterm.mux.get_active_workspace()
        win:perform_action(act.InputSelector {
          action = wezterm.action_callback(function(_, _, id, label)
            if not id and not label then
              wezterm.log_info "Workspace selection canceled"
            else
              win:perform_action(act.SwitchToWorkspace { name = id }, pane)
            end
          end),
          title = "Select workspace",
          choices = workspaces,
        }, pane)
      end),
    },
    {
      --workspaceの名前変更
      key = "$",
      mods = "LEADER",
      action = act.PromptInputLine({
        description = "(wezterm) Set workspace title:",
        action = wezterm.action_callback(function(win, pane, line)
          if line then
            wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
          end
        end),
      }),
    },
    {
      -- workspaceの新規作成
      key = "n",
      mods = "LEADER",
      action = act.PromptInputLine({
        description = "(wezterm) Create new workspace:",
        action = wezterm.action_callback(function(window, pane, line)
          if line then window:perform_action(
              act.SwitchToWorkspace({
                name = line,
              }),
              pane
            )
          end
        end),
      }),
    },
    -- コマンドパレット表示
    { key = "p", mods = "SUPER", action = act.ActivateCommandPalette },
    { key = "p", mods = "SUPER|SHIFT", action = act.ActivateCommandPalette },

    -- Tab移動
    { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
    { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
    { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
    -- Tabの切り替え
    { key = "1", mods = "OPT", action = wezterm.action({ ActivateTab = 0 }) },
    { key = "2", mods = "OPT", action = wezterm.action({ ActivateTab = 1 }) },
    { key = "3", mods = "OPT", action = wezterm.action({ ActivateTab = 2 }) },
    { key = "4", mods = "OPT", action = wezterm.action({ ActivateTab = 3 }) },
    { key = "5", mods = "OPT", action = wezterm.action({ ActivateTab = 4 }) },
    { key = "6", mods = "OPT", action = wezterm.action({ ActivateTab = 5 }) },
    { key = "7", mods = "OPT", action = wezterm.action({ ActivateTab = 6 }) },
    { key = "8", mods = "OPT", action = wezterm.action({ ActivateTab = 7 }) },
    { key = "9", mods = "OPT", action = wezterm.action({ ActivateTab = 8 }) },
    -- Tab新規作成
    { key = "t", mods = "SUPER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
    -- Tabの削除
    { key = "W", mods = "SUPER", action = act({ CloseCurrentTab = { confirm = true } }) },

    -- COPYモードの起動
    { key = "c", mods = "LEADER", action = act.ActivateCopyMode },
    -- コピー
    { key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
    { key = "y", mods = "SUPER", action = act.CopyTo("Clipboard") },
    -- 貼り付け
    { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
    { key = "p", mods = "SUPER", action = act.PasteFrom("Clipboard") },

    -- Pane作成
    { key = "\"", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "%", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    -- Paneを閉じる
    { key = "w", mods = "SUPER", action = act({ CloseCurrentPane = { confirm = true } }) },
    -- Pane移動
    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    -- 選択中のPaneの最大化のトグル
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

    -- フォントサイズ切替
    { key = "+", mods = "SUPER|SHIFT", action = act.IncreaseFontSize },
    { key = "-", mods = "SUPER|SHIFT", action = act.DecreaseFontSize },
    -- フォントサイズのリセット
    { key = "0", mods = "SUPER|SHIFT", action = act.ResetFontSize },

    -- 設定のリロード
    { key = "R", mods = "SUPER", action = act.ReloadConfiguration },
    -- RESIZEモードの起動
    { key = "s", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
    -- SEARCHモードの起動
    { key = "f", mods = "SUPER", action = act.Search { CaseInSensitiveString = "" }, },
  },

  key_tables = {
    -- RESIZEモード（Paneサイズ調整）
    resize_pane = {
      { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
      { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
      { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
      { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
      -- RESIZEモード終了
      { key = "Enter", action = "PopKeyTable" },
    },

    -- COPYモード
    copy_mode = {
      -- 移動
      { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
      { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
      { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
      { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
      -- 行頭と行末に移動
      { key = ",", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
      { key = ".", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
      -- 単語ごと移動
      { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
      { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
      -- 最後尾へ
      { key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
      -- 先頭へ
      { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
      -- 画面上部へ
      { key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
      -- 画面下部へ
      { key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
      -- 画面中央へ
      { key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
      -- スクロール
      { key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
      { key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
      -- 範囲選択モード（文字選択）
      { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
      -- 範囲選択モード（行選択）
      { key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
      -- 範囲選択モード（矩形選択）
      { key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
      -- コピー
      { key = "y", mods = "NONE", action = act.CopyTo("Clipboard") },
      { key = "c", mods = "NONE", action = act.CopyTo("Clipboard") },
      -- COPYモード終了
      { key = "Enter",mods = "NONE", action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }), },
      { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
      { key = "c", mods = "CTRL", action = act.CopyMode("Close") },
      { key = "q", mods = "NONE", action = act.CopyMode("Close") },
    },

    -- SEARCHモード
    search_mode = {
      { key = "Enter", mods = "NONE", action = wezterm.action.CopyMode("PriorMatch") },
      { key = "n", mods = "CTRL", action = wezterm.action.CopyMode("NextMatch") },
      { key = "p", mods = "CTRL", action = wezterm.action.CopyMode("PriorMatch") },
      { key = "Escape", mods = "NONE", action = wezterm.action.Multiple{ wezterm.action.CopyMode 'ClearPattern', wezterm.action.CopyMode 'Close', }},
      { key = "c", mods = "CTRL", action = wezterm.action.Multiple{ wezterm.action.CopyMode 'ClearPattern', wezterm.action.CopyMode 'Close', }},
    },
  },
}