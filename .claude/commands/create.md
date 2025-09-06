---
allowed-tools: Bash(mkdir:*), Bash(date:*), Bash(ls:*), Bash(echo:*)
argument-hint: [theme-type] [theme-hint]
description: 8-Bit Adventure Hub 適応型コレクション作成システム - 物語系・網羅系の最適制作
---

# 🎯 適応型コレクション制作システム

テーマの特性に応じて**物語系**または**網羅系**のアプローチを自動選択し、最適なコレクション構造を生成します。

**引数**: 
- **type**: `adventure` (物語系) または `collection` (網羅系)

## 🎮 制作システム特徴

### 📖 Adventure系 (type: adventure)
**対象**: Ocean Adventure, Forest Journey, Sky Exploration系テーマ
1. **完全な物語体験**: プロローグ → 複数章 → エピローグ構造
2. **キャラクター成長アーク**: 主人公の成長を音楽で表現  
3. **RPGゲーム体験**: 聴く人が実際に冒険を体験
4. **楽曲数**: 25-40曲（物語の深さに応じて）
5. **実際のゲーム流れ**: ドラクエ・FF・ゼルダ等の物語構造を学習適用

### 📋 Collection系 (type: collection)  
**対象**: Battle Music, Dungeon Music, Shop Music, Class Music系テーマ
1. **シーン完全網羅**: そのテーマの全パターンをカバー
2. **機能特化設計**: 用途別・難易度別・タイプ別分類
3. **ゲーム実用性**: 実際のゲーム制作で使える網羅性
4. **楽曲数**: 20-30曲（網羅範囲に応じて）
5. **カテゴリ分類**: 系統立てた整理構造

**例**: Battle Collection → 雑魚戦・中ボス・ラスボス・特殊戦闘等を完全網羅

## 🚀 適応型制作システム開始

制作タイプ: $1 (adventure または collection)
テーマヒント: $2 (任意)

!`echo "🎯 8-Bit Adventure Hub Adaptive Creator v8.0"`

!`echo "📊 システム状況確認中..."`

### システム状況確認
!`if [ -f "/Users/macmini/Dropbox/08-youtube/01-8BAH/CLAUDE.md" ]; then echo "✅ claude.md読み込み完了"; else echo "❌ エラー: claude.md が見つかりません"; fi`

### 成功事例確認（Ocean Adventure Collection参考）
!`if [ -f "/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/20250913-production-ocean-adventure-collection/20-documentation/music-prompts.md" ]; then echo "✅ Ocean Adventure Collection (35楽曲物語構造) 参考データあり"; else echo "⚠️ 物語構造参考データを手動確認してください"; fi`

### Analytics & 投稿状況確認
!`LATEST_LIVE=$(ls -t /Users/macmini/Dropbox/08-youtube/01-8BAH/collections/live/ | head -1 | cut -d'-' -f1); echo "✅ 最新投稿: $LATEST_LIVE"`
!`if [ -d "/Users/macmini/Dropbox/08-youtube/01-8BAH/documentation/analytics" ] && [ "$(ls -A /Users/macmini/Dropbox/08-youtube/01-8BAH/documentation/analytics/)" ]; then echo "✅ Analytics: Adventure系 2.49% CTR, Battle系 2.8% CTR実証済み"; else echo "⚠️ Analytics情報を手動確認してください"; fi`

!`echo "🎮 エピック物語テーマ分析中..."`
!`echo "📖 完全なRPG冒険体験を設計中..."`

### 物語コレクション準備
!`echo "📁 エピック物語システム準備完了"`
!`BASE_DIR="/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production"; echo "✅ 物語体験コレクション制作開始準備完了"`

## 📖 適応型コレクション制作タスク

**制作タイプ「$1」とテーマ「$2」に基づいて、以下を実行してください：**

### 1. 制作タイプ判定と最適設計

#### Adventure系の場合 (type: adventure)

**実際のRPGゲーム構造学習適用**:
- **ドラクエ式**: 明確な目的 → 準備 → 旅立ち → 試練 → 成長 → 最終決戦 → 帰還
- **FF式**: 世界危機 → 仲間集結 → 力の探求 → 敵との対峙 → 犠牲と成長 → 最終勝利
- **ゼルダ式**: 冒険開始 → 能力獲得 → 世界探索 → 謎解き → ボス戦 → 新エリア解放

**RPG物語構造テンプレート**:
- **🌟 OPENING** (2-3曲): 世界設定・事件発生・主人公の決意
- **⚔️ DEPARTURE** (4-5曲): 旅立ち・仲間との出会い・初戦闘
- **🌍 EXPLORATION** (5-7曲): 世界探索・能力成長・小さな試練
- **💀 CRISIS** (4-6曲): 大きな危機・仲間の危険・絶望的状況
- **⚡ AWAKENING** (4-6曲): 真の力覚醒・決戦準備・最終決戦
- **🌅 RESOLUTION** (3-4曲): 勝利・平和・成長実感・新たな旅立ち

#### Collection系の場合 (type: collection)

**完全網羅アプローチ**:

**Battle Music Collection例**:
- **雑魚戦** (6-8曲): 平原・森・洞窟・砂漠・雪原・海上戦闘
- **中ボス戦** (4-6曲): ダンジョンボス・サブボス・精鋭敵
- **ラスボス戦** (4-6曲): 最終決戦・真の姿・絶望的戦闘
- **特殊戦闘** (4-6曲): 空中戦・水中戦・騎乗戦・包囲戦

**Dungeon Music Collection例**:
- **探索系** (6-8曲): 石造り・自然洞窟・古代遺跡・氷の洞窟
- **謎解き系** (4-6曲): 仕掛け・パズル・隠し部屋・宝箱発見
- **危険系** (4-6曲): 罠・毒・呪い・迷路・崩落

### 2. ユーザー確認プロセス

**提案された構造をユーザー確認後、以下を実行：**

1. **構造確定**：Adventure系は物語、Collection系は網羅構造で進行
2. **8-bit & 16-bit同時制作**：同一テーマを2つの音質で表現
3. **ディレクトリ作成**：テーマ名を反映したコレクション構造構築
4. **文書生成**：専用プロンプト・YouTube文書・ビジュアル作成

**テーマに最適化された完全オリジナルコンテンツを制作します。**

## 🎮 制作実行指示

### claude.md準拠での制作
**すべての制作技法はclaude.mdに記載済みのため、以下を参照して実行：**

1. **プロンプト作成**: claude.mdの「SunoAIプロンプト技法」セクション参照
   - Adventure系: Ocean Adventure Collection成功構造適用
   - Collection系: 網羅性重視の機能特化構造適用

2. **YouTube文書作成**: claude.mdの「YouTube コンテンツ戦略」セクション参照  
   - 概要欄テンプレート改革版(v5.0)適用
   - Over-promotional問題回避

3. **ビジュアル制作**: claude.mdの「CTR最適化Midjourneyビジュアル制作技法」参照
   - ヒューマンファクター統合
   - 誇張表現完全回避
   - モバイル最適化

### ディレクトリ作成指示

確定したテーマに基づいて、以下の構造で8-bit & 16-bit同時制作：

```
/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/
├── [日付]-production-8bit-[テーマ名]/
└── [日付+2]-production-16bit-[テーマ名]/
```

**標準ディレクトリ構造**: claude.md記載の構造に準拠

## 🎯 制作完了後の出力

!`echo "🎉 適応型コレクション制作完了！"`
!`echo "📊 制作サマリー:"`
!`echo "✅ 制作タイプ: $1 系アプローチ適用"`
!`echo "✅ テーマ: $2 特化設計"`
!`echo "✅ 音質バリエーション: 8-bit & 16-bit 並列制作"`
!`echo "✅ 制作時間: 5分 (claude.md準拠・100倍高速)"`
!`echo "🚀 次回アクション: SunoAI生成開始 → production移行"`

**最終確認事項**:
1. 制作タイプ（adventure または collection）とテーマ名
2. Adventure系: 物語構造・キャラクター成長アーク
3. Collection系: 網羅カテゴリ・分類構造
4. 楽曲数（Adventure: 25-40曲, Collection: 20-30曲）
5. 8-bit & 16-bit 両バージョンのディレクトリパス

**claude.md準拠**: 全制作技法をclaude.mdから自動適用・重複記載を完全排除