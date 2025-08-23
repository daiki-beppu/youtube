# 🎓 Academy & Magic School Collection - 動画作成バッチ

## 📋 基本情報
- **コレクション名**: Academy & Magic School Collection
- **楽曲数**: 25曲
- **総時間**: 1:37:51 (5,871秒)
- **サムネイル**: `thumbnail.png` (各ディレクトリに配置)

## 🎬 FFmpeg 動画作成コマンド集

### マスター動画作成（フル版）
```bash
cd "/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/20250823-production-collection-academy-magic-school"

# マスター動画作成
ffmpeg -y -loop 1 \
  -i "10-thumbnail/academy-main-thumbnail.png" \
  -i "01-master/00-academy-magic-master.wav" \
  -c:v libx264 -c:a aac -shortest \
  "01-master/00-academy-magic-master.mp4"
```

### 個別動画一括作成
```bash
cd "/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/20250823-production-collection-academy-magic-school"

# 個別楽曲動画作成バッチ
for i in {01..25}; do
  if [ $i -eq 1 ]; then
    input_file="01-Academy Gates Opening.wav"
  elif [ $i -eq 2 ]; then
    input_file="02-Dormitory Welcome Night.wav"
  elif [ $i -eq 3 ]; then
    input_file="03-First Magic Lesson.wav"
  elif [ $i -eq 4 ]; then
    input_file="04-Library of Ancient Wisdom.wav"
  elif [ $i -eq 5 ]; then
    input_file="05-Making First Friends.wav"
  elif [ $i -eq 6 ]; then
    input_file="06-Potion Brewing Class.wav"
  elif [ $i -eq 7 ]; then
    input_file="07-Spell Practice Grounds.wav"
  elif [ $i -eq 8 ]; then
    input_file="08-Magical Creatures Study.wav"
  elif [ $i -eq 9 ]; then
    input_file="09-Advanced Spellcasting.wav"
  elif [ $i -eq 10 ]; then
    input_file="10-Midterm Examination.wav"
  elif [ $i -eq 11 ]; then
    input_file="11-Forbidden Forest Expedition.wav"
  elif [ $i -eq 12 ]; then
    input_file="12-Ancient Ruins Discovery.wav"
  elif [ $i -eq 13 ]; then
    input_file="13-Magical Beast Encounter.wav"
  elif [ $i -eq 14 ]; then
    input_file="14-Team Spell Combination.wav"
  elif [ $i -eq 15 ]; then
    input_file="15-Rescue Mission Success.wav"
  elif [ $i -eq 16 ]; then
    input_file="16-Mastering Elemental Magic.wav"
  elif [ $i -eq 17 ]; then
    input_file="17-Student Council Leadership.wav"
  elif [ $i -eq 18 ]; then
    input_file="18-Magic Tournament Champion.wav"
  elif [ $i -eq 19 ]; then
    input_file="19-Teaching Junior Students.wav"
  elif [ $i -eq 20 ]; then
    input_file="20-Academy Graduation Day.wav"
  elif [ $i -eq 21 ]; then
    input_file="21-Secret Magic Society.wav"
  elif [ $i -eq 22 ]; then
    input_file="22-Love Under Starlight.wav"
  elif [ $i -eq 23 ]; then
    input_file="23-Final Boss_ Dark Sorcerer.wav"
  elif [ $i -eq 24 ]; then
    input_file="24-Academy's Golden Future.wav"
  elif [ $i -eq 25 ]; then
    input_file="25-Legends Never Die.wav"
  fi
  
  ffmpeg -y -loop 1 \
    -i "10-thumbnail/academy-individual-thumbnail.png" \
    -i "02-Individual-music/${input_file}" \
    -c:v libx264 -c:a aac -shortest \
    "03-Individual-movie/${input_file%.*}.mp4"
    
  echo "Created video for track $i: ${input_file%.*}.mp4"
done
```

### 実行時間目安チェック
```bash
# 処理開始前に実行
echo "Starting Academy video creation at: $(date)"
start_time=$(date +%s)

# [上記FFmpegコマンド実行]

# 処理完了後に実行
end_time=$(date +%s)
duration=$((end_time - start_time))
echo "Academy video creation completed at: $(date)"
echo "Total processing time: $duration seconds"
echo "Processing speed: approximately $((5871 / duration))x real-time"
```

## 📁 ディレクトリ構造確認
```bash
# 作業開始前の構造確認
cd "/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/20250823-production-collection-academy-magic-school"

echo "=== Directory Structure Check ==="
echo "01-master contents:"
ls -la "01-master/"
echo ""
echo "02-Individual-music contents:"
ls -la "02-Individual-music/" | head -10
echo ""
echo "10-thumbnail contents:"
ls -la "10-thumbnail/"
echo ""
echo "03-Individual-movie directory exists:"
mkdir -p "03-Individual-movie"
ls -la "03-Individual-movie/"
```

## 🎯 楽曲リスト（25曲）

### 🚪 Academy Life Begins (01-05)
1. **01-Academy Gates Opening.wav** (2:58)
2. **02-Dormitory Welcome Night.wav** (3:33) 
3. **03-First Magic Lesson.wav** (5:04)
4. **04-Library of Ancient Wisdom.wav** (2:44)
5. **05-Making First Friends.wav** (4:04)

### 📚 Learning & Growth (06-10)
6. **06-Potion Brewing Class.wav** (3:53)
7. **07-Spell Practice Grounds.wav** (3:17)
8. **08-Magical Creatures Study.wav** (3:47)
9. **09-Advanced Spellcasting.wav** (4:23)
10. **10-Midterm Examination.wav** (3:30)

### 🌲 Adventures & Challenges (11-15)
11. **11-Forbidden Forest Expedition.wav** (4:01)
12. **12-Ancient Ruins Discovery.wav** (4:38)
13. **13-Magical Beast Encounter.wav** (4:04)
14. **14-Team Spell Combination.wav** (3:34)
15. **15-Rescue Mission Success.wav** (6:09)

### ✨ Mastery & Leadership (16-20)
16. **16-Mastering Elemental Magic.wav** (6:30)
17. **17-Student Council Leadership.wav** (2:28)
18. **18-Magic Tournament Champion.wav** (5:09)
19. **19-Teaching Junior Students.wav** (2:47)
20. **20-Academy Graduation Day.wav** (3:24)

### 🌟 Beyond Academy (21-25)
21. **21-Secret Magic Society.wav** (2:47)
22. **22-Love Under Starlight.wav** (2:48)
23. **23-Final Boss_ Dark Sorcerer.wav** (4:24)
24. **24-Academy's Golden Future.wav** (3:11)
25. **25-Legends Never Die.wav** (4:41)

## 🔧 トラブルシューティング

### よくあるエラーと対処法

#### ファイル名のスペース問題
```bash
# スペースを含むファイル名は必ずダブルクォートで囲む
ffmpeg -i "02-Individual-music/01-Academy Gates Opening.wav"
```

#### サムネイル画像の確認
```bash
# サムネイル画像の存在確認
ls -la "10-thumbnail/"
file "10-thumbnail/academy-main-thumbnail.png"
```

#### 出力ディレクトリの作成
```bash
# 出力ディレクトリが存在しない場合は作成
mkdir -p "03-Individual-movie"
```

## 📊 品質設定

### 推奨設定値
- **ビデオコーデック**: libx264
- **オーディオコーデック**: aac
- **解像度**: 1280x720 (HD)
- **フレームレート**: 自動（静止画なので影響なし）
- **音質**: デフォルト（高品質）

### 高速処理オプション（必要時）
```bash
# より高速な処理が必要な場合
ffmpeg -y -loop 1 \
  -i "thumbnail.png" \
  -i "audio.wav" \
  -c:v libx264 -preset ultrafast \
  -c:a aac -shortest \
  "output.mp4"
```

## ✅ 完了チェックリスト

### 作業完了後の確認項目
- [ ] マスター動画（00-academy-magic-master.mp4）作成完了
- [ ] 個別動画25本すべて作成完了
- [ ] ファイル名に問題がないか確認
- [ ] 動画の再生時間が音声ファイルと一致するか確認
- [ ] サムネイル画像が正しく表示されるか確認
- [ ] 音質に問題がないか確認

### ファイル数確認
```bash
# 作成された動画ファイル数の確認
echo "Master videos: $(ls -1 01-master/*.mp4 2>/dev/null | wc -l)"
echo "Individual videos: $(ls -1 03-Individual-movie/*.mp4 2>/dev/null | wc -l)"
echo "Total expected: 26 videos (1 master + 25 individual)"
```

## 🎬 次のステップ

### 動画作成完了後
1. **YouTube投稿準備**
   - フル動画のアップロード
   - 個別動画の一括アップロード
   - プレイリスト作成

2. **概要欄設定**
   - `20250821-academy-full-description.md` を使用
   - `20250821-academy-playlist-description.md` を使用

3. **サムネイル設定**  
   - `20250821-academy-character-consistent-thumbnails.md` のプロンプトを使用
   - Midjourney v7で各動画用サムネイル生成

**推定作業時間**: 約20-30分（25楽曲 × 約10-11x処理速度）