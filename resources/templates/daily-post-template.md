# 日次投稿テンプレート

## 個別楽曲投稿の命名規則

### ディレクトリ名
```
YYYYMMDD-LIVE-individual-TRACK-NAME/
```

**例**: `20250817-LIVE-individual-dawn-of-legends`

## 毎日投稿スケジュール

### Adventure Season 2 (37楽曲) - 8/17〜9/23
```
Day 1 (8/17): 01-Dawn_of_Legends
Day 2 (8/18): 02-Village_of_Destiny
Day 3 (8/19): 03-Emerald_Plains_of_Hope
Day 4 (8/20): 04-Summit_of_the_Gods
Day 5 (8/21): 05-Fortress_of_the_Sky
Day 6 (8/22): 06-Citadel_of_Clouds
Day 7 (8/23): 07-Baptism_of_Steel
Day 8 (8/24): 08-Winds_of_Adventure
Day 9 (8/25): 09-Tides_of_Destiny
Day 10 (8/26): 10-Harbor_of_Dreams
Day 11 (8/27): 11-Voyage_to_the_Unknown
Day 12 (8/28): 12-Enchanted_Realm
Day 13 (8/29): 13-Whispers_of_the_Wild
Day 14 (8/30): 14-Sanctuary_of_Ancients
Day 15 (8/31): 15-Guardians_Awakening
Day 16 (9/1): 16-Realm_of_Eternal_Ice
Day 17 (9/2): 17-Crystal_Throne
Day 18 (9/3): 18-Palace_of_Frozen_Dreams
Day 19 (9/4): 19-Crown_of_the_Empire
Day 20 (9/5): 20-Halls_of_Arcane_Power
Day 21 (9/6): 21-Sands_of_Eternity
Day 22 (9/7): 22-Mirage_of_Heroes
Day 23 (9/8): 23-Fields_of_Fire
Day 24 (9/9): 24-Heart_of_the_Inferno
Day 25 (9/10): 25-Forge_of_the_Titans
Day 26 (9/11): 26-Dance_of_Dragons
Day 27 (9/12): 27-Tomb_of_Kings
Day 28 (9/13): 28-Tower_of_Destinies
Day 29 (9/14): 29-Wings_of_Thunder
Day 30 (9/15): 30-Depths_of_Atlantis
Day 31 (9/16): 31-Abyssal_Cathedral
Day 32 (9/17): 32-Carnival_of_Heroes
Day 33 (9/18): 33-Victory_Celebration
Day 34 (9/19): 34-Temple_of_Shadows
Day 35 (9/20): 35-City_of_the_Fallen
Day 36 (9/21): 36-Clash_of_Eternities
Day 37 (9/22): 37-Dawn_of_New_Legends
```

## 投稿作業フロー

### 1. 準備（前日）
1. 翌日投稿楽曲の確認
2. 個別動画ファイルの準備
3. 概要欄ドラフト作成

### 2. 投稿当日
1. YouTube 投稿（午前中推奨）
2. プレイリストに追加
3. SNS 告知（必要に応じて）

### 3. 投稿後
1. URL 記録
2. 次回作業の準備
3. アナリティクス確認

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
🔔 Subscribe for daily 8-Bit BGM adventures!
👍 Like if this track enhanced your adventure!
💬 Comment which adventure this reminds you of!
🔄 Share with fellow adventurers!

🎮 MORE ADVENTURE MUSIC:
[OTHER_COLLECTIONS_LINKS]

#8BitMusic #AdventureMusic #EpicMusic #StudyBGM #RPGMusic #8BitAdventureHub #GamingMusic #ChiptuneStudy #FantasyMusic
```

## 管理ディレクトリ

### individuals/daily-posts/
```
individuals/daily-posts/
├── 20250817-dawn-of-legends/
├── 20250818-village-of-destiny/
├── 20250819-emerald-plains/
└── ...
```

### individuals/ready-queue/
投稿予定の楽曲を準備

### individuals/archives/
投稿完了楽曲をアーカイブ

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
*8-Bit Adventure Hub - 毎日投稿システム*