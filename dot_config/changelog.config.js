module.exports = {
  disableEmoji: false,
  format: '{type}: {emoji}{subject}',
  list: [
    'feat',
    'update',
    'change',
    'design',
    'remove',
    'fix',
    'test',
    'docs',
    'setup',
    'refactor',
    'release',
    'perf',
  ],
  maxMessageLength: 64,
  minMessageLength: 2,
  questions: [
    'type',
    'subject',
    'body',
    'issues',
  ],
  types: {
    feat: {
      description: '新機能の実装',
      emoji: '🎉',
      value: 'feat',
    },
    update: {
      description: 'バグではない機能更新',
      emoji: '⤴️',
      value: 'update',
    },
    change: {
      description: '仕様変更による機能変更',
      emoji: '🔄',
      value: 'change',
    },
    design: {
      description:
        'デザイン調整',
      emoji: '🎨',
      value: 'design',
    },
    remove: {
      description: '機能/ファイルの削除',
      emoji: '🔥',
      value: 'remove',
    },
    fix: {
      description: 'バグ修正',
      emoji: '🐛',
      value: 'fix',
    },
    test: {
      description: 'テスト',
      emoji: '🧪',
      value: 'test',
    },
    docs: {
      description: 'ドキュメント関連',
      emoji: '📚',
      value: 'docs',
    },
    setup: {
      description: '環境構築/設定',
      emoji: '⚙️',
      value: 'setup',
    },
    refactor: {
      description: 'リファクタリング',
      emoji: '🛠️',
      value: 'refactor',
    },
    release: {
      description: 'デプロイ',
      emoji: '🚀',
      value: 'release',
    },
    perf: {
      description: 'パフォーマンスチューニング',
      emoji: '⚡️',
      value: 'perf',
    },
  },
  messages: {
    type: 'コミットする内容はどの型ですか:',
    subject: '変更内容を簡潔に書いてください:\n',
    body: '変更内容の詳細があれば書いてください:\n ',
    issues: '対応issueがあれば書いてください。例： #123:',
  },
};