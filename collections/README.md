# 🎵 Collections - コレクション管理システム

**8-Bit Adventure Hub** のすべての音楽コレクションを効率的に管理するディレクトリです。

## 📁 ディレクトリ構造

```
collections/
├── live/           # 投稿済み・公開中コレクション
├── ready/          # 投稿準備完了・公開待ちコレクション
├── production/     # 制作中コレクション
├── planning/       # 企画中コレクション
└── archives/       # アーカイブコレクション
```

## 🔄 コレクションのライフサイクル

### ワークフロー
```
planning → production → ready → live
```

1. **Planning（企画段階）**
   - テーマ・コンセプト決定
   - 楽曲リスト作成
   - プロンプト戦略策定

2. **Production（制作段階）**
   - Suno での楽曲制作
   - 個別ファイル生成
   - 動画制作

3. **Ready（準備完了段階）**
   - マスターファイル作成
   - サムネイル完成
   - 概要欄作成
   - 投稿スケジュール設定

4. **Live（投稿済み段階）**
   - YouTube 投稿完了
   - URL 記録
   - アナリティクス監視

## 🚀 2日間投稿システム

### 📅 投稿サイクル
```
Day 1: Complete Collection（フル動画・長尺版）投稿
Day 2: 全楽曲を個別動画として一斉投稿 + 再生リスト作成
```

### 🎯 投稿例
```
Guild Collection:
Day 1 (20250818): Guild Collection フル動画投稿（1-2時間）
Day 2 (20250819): Guild 全楽曲（約20曲）個別投稿 + プレイリスト作成

Adventure Season 2:
Day 1: Adventure Season 2 フル動画投稿（3:50:32）✅
Day 2: 全37楽曲を個別投稿 + プレイリスト作成（予定）
```

### 🎯 システムの価値
- **視聴者選択肢**: フル視聴 or 個別楽曲選択
- **SEO 効果**: 個別楽曲名での検索網羅
- **プレイリスト活用**: 用途別・気分別の柔軟な利用
- **内部循環**: 個別楽曲→フルコレクションへの誘導

## 📋 命名規則

### 新規コレクション
```
YYYYMMDD-STATUS-TYPE-NAME/
```

**例**: `20250817-READY-collection-ocean-adventure/`

#### STATUS（ステータス）
- **PLAN**: 企画中・コンセプト検討段階
- **PROD**: 制作中・音楽生成段階
- **READY**: 投稿準備完了・公開待ち
- **LIVE**: 投稿済み・公開中

#### TYPE（タイプ）
- **collection**: 長尺コレクション（15-40楽曲）
- **individual**: 個別楽曲（単発投稿）
- **special**: 特別企画（ライブ、コラボ等）

### レガシーコレクション
過去のコレクション（001-adventure 〜 010-boss-rush）は現在の名前を維持し、すべて `live/` に配置されています。

## 🎯 現在の状況

### Live（投稿済み）- 11コレクション ✅
1. `001-adventure/` - Adventure Music（24曲・1:00:00）
2. `002-buttle/` - Battle Music（13曲・1:00:00）
3. `003-dungeon/` - Dungeon Music（16曲・1:00:00）
4. `004-village/` - Village & Town Music（18曲・1:20:00）
5. `005-j-rpg/` - Japanese RPG Music（22曲・1:30:00）
6. `006−emotional/` - Emotional Journey Music（20曲・1:30:00）
7. `007-shop-and-inn/` - Shop & Inn Music（20曲・1:00:00+）
8. `008-sleep-dream/` - Sleep & Dream Music（26曲・1:30:00）
9. `009-class/` - RPG Class Music（20曲・1:23:22）
10. `010-boss-rush/` - Boss Rush Music（18曲・1:14:22）
11. `20250816-LIVE-collection-adventure-season-2/` - Adventure Season 2（37曲・3:50:32）

### Production（制作中）- 2コレクション 🚧
- `20250818-production-collection-guild/` - Guild Hall Adventure（進行中）
- `20250820-producion-collection-world-map/` - World Map Travel（企画段階）

**総制作時間**: 15.7+ 時間  
**総楽曲数**: 271曲  
**プロジェクト規模**: 約35GB

## 📝 作業手順

### 新規コレクション作成
1. `planning/` でディレクトリ作成
2. コンセプト・楽曲リスト策定
3. `production/` に移動して制作開始
4. 完成後 `ready/` に移動
5. 投稿後 `live/` に移動

### ディレクトリ移動
```bash
# 企画完了時
mv collections/planning/YYYYMMDD-PLAN-collection-NAME collections/production/YYYYMMDD-PROD-collection-NAME

# 制作完了時
mv collections/production/YYYYMMDD-PROD-collection-NAME collections/ready/YYYYMMDD-READY-collection-NAME

# 投稿完了時
mv collections/ready/YYYYMMDD-READY-collection-NAME collections/live/YYYYMMDD-LIVE-collection-NAME
```

## 🔍 参考資料

- **メインガイド**: `/CLAUDE.md`
- **マスターナレッジ**: `/documentation/00-unified-knowledge-base.md`
- **制作テンプレート**: `/resources/templates/new-collection-template.md`
- **プロンプト技法**: プロジェクト文書内で詳説

---

*最終更新: 2025-08-16*  
*8-Bit Adventure Hub - Collections 管理システム*