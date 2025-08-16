# 2日間集中投稿テンプレート

## 投稿システム概要

### 📅 2日間投稿サイクル
```
Day 1: Complete Collection（フル動画・長尺版）投稿
Day 2: 全楽曲を個別動画として一斉投稿 + 再生リスト作成
```

## 個別楽曲投稿の命名規則

### ディレクトリ名
```
YYYYMMDD-LIVE-individual-TRACK-NAME/
```

**例**: `20250819-LIVE-individual-dawn-of-legends`

## 投稿スケジュール例

### Guild Collection (20250818-19)
```
Day 1 (20250818): Guild Collection フル動画投稿（1-2時間）
Day 2 (20250819): Guild 全楽曲（約20曲）個別投稿 + プレイリスト作成
```

### Adventure Season 2 (投稿済み例)
```
Day 1: Adventure Season 2 フル動画投稿（3:50:32）✅
Day 2: 全37楽曲を個別投稿 + プレイリスト作成（予定）
```

## 投稿作業フロー

### Day 1: Complete Collection 投稿
1. **準備**
   - フル動画・音声ファイル確認
   - メイン概要欄作成
   - サムネイル最終確認

2. **投稿実行**
   - YouTube フル動画投稿
   - URL 記録
   - 初期プロモーション

### Day 2: 個別楽曲一斉投稿
1. **準備**
   - 全個別動画ファイル確認
   - 個別概要欄一括作成
   - プレイリスト設定準備

2. **一斉投稿実行**
   - 全楽曲を個別動画として投稿
   - 再生リスト作成・整理
   - 内部循環リンク設定

3. **投稿後処理**
   - 全URL記録
   - プレイリストURL更新
   - アナリティクス監視開始

## 概要欄テンプレート（個別楽曲用）

```markdown
🎵 [TRACK_NAME] - 8-Bit Adventure Music 🎵

Experience this epic track from our Adventure Season 2 collection! Perfect for RPG adventures, study sessions, and creative projects.

🎮 FROM THE COMPLETE ADVENTURE SEASON 2:
This is track [XX] from our 3:50:32 epic adventure masterpiece:
➤ **Full Collection**: [FULL_VIDEO_URL]
➤ **Complete Playlist**: [PLAYLIST_URL]

🎯 PERFECT FOR:
✅ RPG adventure scenes & D&D campaigns
✅ Study sessions & focus work
✅ Creative writing & storytelling
✅ Gaming streams & content creation

🎵 ABOUT THIS TRACK:
[TRACK_DESCRIPTION - 2-3 sentences about the mood and story]

📱 CONNECT WITH US:
🔔 Subscribe for epic 8-Bit BGM collections!
👍 Like if this track enhanced your adventure!
💬 Comment which adventure this reminds you of!
🔄 Share with fellow adventurers!

🎮 MORE ADVENTURE MUSIC:
[OTHER_COLLECTIONS_LINKS]

#8BitMusic #AdventureMusic #EpicMusic #StudyBGM #RPGMusic #8BitAdventureHub #GamingMusic #ChiptuneStudy #FantasyMusic
```

## ファイル管理

### 個別楽曲ファイル配置
```
collections/live/[COLLECTION-NAME]/
├── 02-Individual-music/     # 個別音声ファイル
├── 03-Individual-movie/     # 個別動画ファイル
└── 10-thumbnail/           # 個別サムネイル
```

### プレイリスト管理
```
YouTube プレイリスト作成後:
□ プレイリストURL記録
□ 概要欄・メタデータ更新
□ 内部循環リンク設定
□ SEO最適化確認
```

## 自動化要素

### バッチ処理スクリプト（将来実装）
```bash
# ファイル名変換
# 概要欄生成
# プレイリスト追加
# URL記録
```

---

*作成日: 2025-08-16*  
*8-Bit Adventure Hub - 2日間集中投稿システム*