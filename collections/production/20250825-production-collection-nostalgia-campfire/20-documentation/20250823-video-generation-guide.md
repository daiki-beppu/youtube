# 🔥 Nostalgia & Campfire Collection - 動画生成ガイド

## 📅 作成日時
2025-08-23

## 🎯 概要
騎士が焚き火で物思いにふけるMidjourney生成画像を使用して、マスター動画 + 個別楽曲動画22本を一括生成するガイド。

## 🖼️ 使用素材

### Midjourney生成画像
- **プロンプト**: `a weary knight lost in thought beside a small campfire in dark woods, helmet placed nearby, contemplating memories under starlit night sky, warm orange firelight --ar 16:9`
- **ファイルパス**: `/Users/macmini/Downloads/u5217824488_a_weary_knight_lost_in_thought_beside_a_small_cam_8eb5eb4e-e11e-4208-ba56-a26bb9f0d396_0.png`
- **画像サイズ**: 1456x816px
- **テーマ**: 物思いにふける騎士、ノスタルジックな焚き火シーン

## 🎬 動画生成仕様

### 動画設定
- **解像度**: 1920x1080 (YouTube最適化)
- **フレームレート**: 30fps
- **映像コーデック**: H.264 (libx264)
- **音声コーデック**: AAC
- **特殊効果**: 0.5倍速 (`setpts=2.0*PTS`) - ゆったりした雰囲気演出

### 生成内容
1. **マスター動画**: `00-nostalgia-campfire-master.mp4` (約86分)
2. **個別動画**: 22本の楽曲別動画 (各楽曲の長さに対応)

## 🚀 使用方法

### 前提条件
- FFmpeg インストール済み
- Nostalgia & Campfire Collection の楽曲ファイル準備完了
- Midjourney生成画像のダウンロード完了

### Step 1: ディレクトリ移動
```bash
cd "/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/20250825-production-collection-nostalgia-campfire"
```

### Step 2: 実行権限付与
```bash
chmod +x generate-all-campfire-videos.sh
```

### Step 3: スクリプト実行
```bash
./generate-all-campfire-videos.sh
```

### Step 4: 処理完了確認
```bash
ls -la 03-Individual-movie/
```

## 📊 処理時間の目安

### 推定処理時間
- **マスター動画**: 約10-15分 (86分の動画生成)
- **個別動画22本**: 約30-45分 (各楽曲の長さに依存)
- **総処理時間**: 約40-60分

### 処理順序
1. マスター音声の長さ確認
2. マスター動画生成 (0.5倍速ループ + 音声合成)
3. 個別楽曲動画22本を順次生成
4. 結果サマリー表示

## 📁 生成されるファイル

### ファイル構成
```
03-Individual-movie/
├── 00-nostalgia-campfire-master.mp4     # Complete Collection用 (約86分)
├── 01-First Campfire Night.mp4          # 個別楽曲 #1
├── 02-Young Adventurer's Dream.mp4      # 個別楽曲 #2
├── 03-Village We Left Behind.mp4        # 個別楽曲 #3
├── ...
└── 22-Until We Meet Again.mp4           # 個別楽曲 #22
```

### ファイルサイズ目安
- **マスター動画**: 約2-3GB (86分)
- **個別動画**: 各50-200MB (楽曲の長さに依存)
- **総容量**: 約4-6GB

## 🎯 YouTube投稿用途

### Complete Collection (マスター動画)
- **用途**: メイン投稿、長時間BGM
- **タイトル**: "🔥 Nostalgia & Campfire Collection - 22 tracks, 1:26:00"
- **概要欄**: タイムスタンプ付きの完全版

### Individual Tracks (個別動画)
- **用途**: 個別楽曲投稿、再生リスト構成
- **タイトル**: 楽曲名をそのまま使用
- **概要欄**: 統一版テンプレート使用

## ⚠️ 注意事項

### トラブルシューティング
1. **画像ファイルが見つからない**
   - パスを確認: `/Users/macmini/Downloads/u5217824488...`
   - ファイルが存在するか確認

2. **音声ファイルが見つからない**
   - `01-master/00-nostalgia-master.wav` の存在確認
   - ファイル権限の確認

3. **FFmpeg エラー**
   - FFmpeg インストール確認: `ffmpeg -version`
   - ディスク容量確認 (6GB以上推奨)

4. **処理中断**
   - 既存ファイルは自動スキップ
   - 再実行で未完了分のみ処理

### 最適化のヒント
- **バックグラウンド実行**: `nohup ./generate-all-campfire-videos.sh > generation.log 2>&1 &`
- **進行確認**: `tail -f generation.log`
- **並列処理**: 大量のファイル処理時は検討

## 🎨 カスタマイズ

### プロンプト改良案
基本プロンプトをベースに、章別の雰囲気に合わせて画像を差し替え可能：

#### 第1章用 (旅立ちの記憶)
```
a young knight by campfire on first adventure, hopeful expression, village lights in distance, medieval fantasy, warm flames, dreamy nostalgic night --ar 16:9
```

#### 第5章用 (人生の真理)
```
an elder knight contemplating eternal flame, profound wisdom, medieval fantasy, mystical immortality theme, cosmic continuation, warm spiritual firelight --ar 16:9
```

## 📈 期待効果

### コンテンツ戦略
- **長時間BGM需要**: 86分の長尺コンテンツ
- **個別楽曲訴求**: 22本の個別動画で幅広いリーチ
- **ビジュアル統一**: 焚き火テーマで8BAHブランド強化
- **感情訴求**: ノスタルジー・内省・人生哲学の表現

### 技術的優位性
- **0.5倍速効果**: ゆったりした雰囲気でリラックス効果
- **高品質映像**: 1920x1080・30fps でYouTube最適化
- **効率的制作**: 一括生成で作業時間大幅短縮