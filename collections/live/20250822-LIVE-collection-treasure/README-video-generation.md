# 🏺 Treasure Collection - 動画生成ガイド

## 🎬 バッチ処理スクリプト

### 全動画一括生成（推奨）
```bash
./generate-all-videos.sh
```
- マスター + 個別22本を一度に生成
- 合計23本の動画を自動作成

### マスター動画生成
```bash
./generate-master-video.sh
```
- 全22楽曲を統合したマスター動画
- ファイル名: `00-treasure-master.mp4` (1:46:21)
- 01-master/ ディレクトリに配置

### 個別楽曲動画生成
```bash
./generate-chapter-videos.sh
```
- 22楽曲すべてを個別動画として生成
- ファイル名: `01-Ancient-Map-Discovery.mp4` など
- サムネイル: `10-thumbnail/thambnail.png` 使用

## 📁 生成される動画ファイル

### マスター動画 (1本)
```
01-master/00-treasure-master.mp4 (1:46:21)
01-master/00-treasure-master.wav (既存)
```

### 個別動画 (22本)
```
03-Individual-movie/01-Ancient-Map-Discovery.mp4
03-Individual-movie/02-Journey-to-the-Lost-Temple.mp4
03-Individual-movie/03-First-Glimpse-of-Ruins.mp4
03-Individual-movie/04-Crossing-the-Sacred-Threshold.mp4
03-Individual-movie/05-Stone-Corridor-Echoes.mp4
...（全22楽曲）
03-Individual-movie/22-Victorious-Return-Journey.mp4
```

## 🎯 章構成

### 🗺️ 第1章: Discovery & Journey (4楽曲)
- Ancient Map Discovery
- Journey to the Lost Temple
- First Glimpse of Ruins
- Crossing the Sacred Threshold

### 🏛️ 第2章: Temple Exploration (6楽曲)
- Stone Corridor Echoes
- Hall of Forgotten Kings
- Hidden Chamber Revelation
- Guardian Statues Awakening
- Underground River Crossing
- Crystal Cave Illumination

### 🧩 第3章: Trials & Mysteries (5楽曲)
- Ancient Symbol Decoding
- Mechanical Puzzle Chamber
- Trial of the Four Elements
- Shadow Guardian Encounter
- Ancient Wisdom Test

### 💎 第4章: Treasure Discovery (4楽曲)
- Golden Door Unsealing
- Treasure Chamber Entrance
- Legendary Artifact Discovery
- Ancient Knowledge Revelation

### 🏃 第5章: Escape & Return (3楽曲)
- Temple Collapse Warning
- Race Against Time Escape
- Victorious Return Journey

## ⚙️ 技術仕様

### FFmpeg 設定
- 動画コーデック: H.264 (libx264)
- 音声コーデック: AAC
- フレームレート: 30fps
- ピクセルフォーマット: yuv420p (YouTube最適化)

### ファイル構成
```
20250822-production-collection-treasure/
├── 01-master/                    # マスター動画・音声
│   ├── 00-treasure-master.wav   # 既存マスター音声
│   └── 00-treasure-master.mp4   # 生成されるマスター動画
├── 02-Individual-music/          # 音声ファイル (WAV)
├── 03-Individual-movie/          # 生成された個別動画 (MP4)
├── 10-thumbnail/                 # サムネイル画像
│   └── thambnail.png            # 使用画像（HD-2Dスタイル）
├── generate-all-videos.sh       # 全動画一括生成スクリプト
├── generate-master-video.sh     # マスター動画生成スクリプト
├── generate-chapter-videos.sh   # 個別動画生成スクリプト
└── README-video-generation.md   # このファイル
```

## 🚀 実行方法

1. **全動画一括生成**（推奨）
   ```bash
   cd /Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/20250822-production-collection-treasure
   ./generate-all-videos.sh
   ```

2. **個別実行**（オプション）
   ```bash
   ./generate-master-video.sh     # マスターのみ
   ./generate-chapter-videos.sh   # 個別22本のみ
   ```

3. **生成確認**
   ```bash
   ls -la 01-master/ 03-Individual-movie/
   ```

## 📊 予想処理時間
- マスター動画: 約3-5分
- 個別動画22本: 約15-20分
- 合計処理時間: 約20-25分

## 🏺 YouTube投稿戦略
1. **Day 1**: Complete Collection（マスター動画）投稿
2. **Day 2**: 個別楽曲22本一斉投稿 + プレイリスト作成
3. **継続**: FROM THE COMPLETE COLLECTION による内部循環

---
**🎮 HD-2D美学で描かれた伝説の宝探し冒険、動画生成準備完了や！** ✨