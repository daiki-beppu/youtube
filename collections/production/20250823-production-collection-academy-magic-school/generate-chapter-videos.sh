#!/bin/bash

# 🎓 Academy & Magic School Collection - 章別動画生成バッチ処理
# 25楽曲の個別動画を5章分に分けて自動生成

set -e  # エラー時に停止

# 基本設定
BASE_DIR="/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/20250823-production-collection-academy-magic-school"
MUSIC_DIR="$BASE_DIR/02-Individual-music"
THUMBNAIL="$BASE_DIR/10-thumbnail/thamnail-base.png"
OUTPUT_DIR="$BASE_DIR/03-Individual-movie"

# 出力ディレクトリ作成
mkdir -p "$OUTPUT_DIR"

echo "🎓 Academy & Magic School Collection - 章別動画生成開始"
echo "📁 音楽ディレクトリ: $MUSIC_DIR"
echo "🎨 サムネイル: $THUMBNAIL"
echo "📹 出力先: $OUTPUT_DIR"
echo ""

# サムネイル存在確認
if [ ! -f "$THUMBNAIL" ]; then
    echo "❌ エラー: サムネイルが見つかりません: $THUMBNAIL"
    echo "代替サムネイルを探します..."
    
    echo "既存のサムネイルを確認..."
    ls -la "$BASE_DIR/10-thumbnail/"
    exit 1
fi

# 🚪 第1章: Academy Life Begins (楽曲 1-5)
echo "🚪 第1章: Academy Life Begins 動画生成中..."
CHAPTER1_FILES=(
    "01-Academy Gates Opening.wav"
    "02-Dormitory Welcome Night.wav"
    "03-First Magic Lesson.wav"
    "04-Library of Ancient Wisdom.wav"
    "05-Making First Friends.wav"
)

for i in "${!CHAPTER1_FILES[@]}"; do
    file="${CHAPTER1_FILES[$i]}"
    track_num=$((i + 1))
    input_file="$MUSIC_DIR/$file"
    output_file="$OUTPUT_DIR/${file%.wav}.mp4"
    
    if [ -f "$input_file" ]; then
        echo "  🎵 処理中: $file"
        ffmpeg -y -loop 1 -i "$THUMBNAIL" -i "$input_file" \
               -c:v libx264 -c:a aac -shortest \
               -pix_fmt yuv420p -r 30 \
               "$output_file"
        echo "  ✅ 完了: ${file%.wav}.mp4"
    else
        echo "  ❌ ファイルが見つかりません: $file"
    fi
done

# 📚 第2章: Learning & Growth (楽曲 6-10)
echo ""
echo "📚 第2章: Learning & Growth 動画生成中..."
CHAPTER2_FILES=(
    "06-Potion Brewing Class.wav"
    "07-Spell Practice Grounds.wav"
    "08-Magical Creatures Study.wav"
    "09-Advanced Spellcasting.wav"
    "10-Midterm Examination.wav"
)

for i in "${!CHAPTER2_FILES[@]}"; do
    file="${CHAPTER2_FILES[$i]}"
    track_num=$((i + 6))  # 6から開始
    input_file="$MUSIC_DIR/$file"
    output_file="$OUTPUT_DIR/${file%.wav}.mp4"
    
    if [ -f "$input_file" ]; then
        echo "  🎵 処理中: $file"
        ffmpeg -y -loop 1 -i "$THUMBNAIL" -i "$input_file" \
               -c:v libx264 -c:a aac -shortest \
               -pix_fmt yuv420p -r 30 \
               "$output_file"
        echo "  ✅ 完了: ${file%.wav}.mp4"
    else
        echo "  ❌ ファイルが見つかりません: $file"
    fi
done

# 🌲 第3章: Adventures & Challenges (楽曲 11-15)
echo ""
echo "🌲 第3章: Adventures & Challenges 動画生成中..."
CHAPTER3_FILES=(
    "11-Forbidden Forest Expedition.wav"
    "12-Ancient Ruins Discovery.wav"
    "13-Magical Beast Encounter.wav"
    "14-Team Spell Combination.wav"
    "15-Rescue Mission Success.wav"
)

for i in "${!CHAPTER3_FILES[@]}"; do
    file="${CHAPTER3_FILES[$i]}"
    track_num=$((i + 11))  # 11から開始
    input_file="$MUSIC_DIR/$file"
    output_file="$OUTPUT_DIR/${file%.wav}.mp4"
    
    if [ -f "$input_file" ]; then
        echo "  🎵 処理中: $file"
        ffmpeg -y -loop 1 -i "$THUMBNAIL" -i "$input_file" \
               -c:v libx264 -c:a aac -shortest \
               -pix_fmt yuv420p -r 30 \
               "$output_file"
        echo "  ✅ 完了: ${file%.wav}.mp4"
    else
        echo "  ❌ ファイルが見つかりません: $file"
    fi
done

# ✨ 第4章: Mastery & Leadership (楽曲 16-20)
echo ""
echo "✨ 第4章: Mastery & Leadership 動画生成中..."
CHAPTER4_FILES=(
    "16-Mastering Elemental Magic.wav"
    "17-Student Council Leadership.wav"
    "18-Magic Tournament Champion.wav"
    "19-Teaching Junior Students.wav"
    "20-Academy Graduation Day.wav"
)

for i in "${!CHAPTER4_FILES[@]}"; do
    file="${CHAPTER4_FILES[$i]}"
    track_num=$((i + 16))  # 16から開始
    input_file="$MUSIC_DIR/$file"
    output_file="$OUTPUT_DIR/${file%.wav}.mp4"
    
    if [ -f "$input_file" ]; then
        echo "  🎵 処理中: $file"
        ffmpeg -y -loop 1 -i "$THUMBNAIL" -i "$input_file" \
               -c:v libx264 -c:a aac -shortest \
               -pix_fmt yuv420p -r 30 \
               "$output_file"
        echo "  ✅ 完了: ${file%.wav}.mp4"
    else
        echo "  ❌ ファイルが見つかりません: $file"
    fi
done

# 🌟 第5章: Beyond Academy (楽曲 21-25)
echo ""
echo "🌟 第5章: Beyond Academy 動画生成中..."
CHAPTER5_FILES=(
    "21-Secret Magic Society.wav"
    "22-Love Under Starlight.wav"
    "23-Final Boss_ Dark Sorcerer.wav"
    "24-Academy's Golden Future.wav"
    "25-Legends Never Die.wav"
)

for i in "${!CHAPTER5_FILES[@]}"; do
    file="${CHAPTER5_FILES[$i]}"
    track_num=$((i + 21))  # 21から開始
    input_file="$MUSIC_DIR/$file"
    output_file="$OUTPUT_DIR/${file%.wav}.mp4"
    
    if [ -f "$input_file" ]; then
        echo "  🎵 処理中: $file"
        ffmpeg -y -loop 1 -i "$THUMBNAIL" -i "$input_file" \
               -c:v libx264 -c:a aac -shortest \
               -pix_fmt yuv420p -r 30 \
               "$output_file"
        echo "  ✅ 完了: ${file%.wav}.mp4"
    else
        echo "  ❌ ファイルが見つかりません: $file"
    fi
done

echo ""
echo "🎉 全章の動画生成が完了しました！"
echo "📁 生成ファイル確認: $OUTPUT_DIR"
echo ""

# 生成されたファイル一覧表示
echo "📋 生成された動画ファイル："
ls -la "$OUTPUT_DIR" | grep "\.mp4" | while read -r line; do
    echo "  $line"
done

# 生成ファイル数確認
GENERATED_COUNT=$(ls -1 "$OUTPUT_DIR"/*.mp4 2>/dev/null | wc -l || echo 0)
echo ""
echo "✅ 生成完了: ${GENERATED_COUNT}本の動画ファイル"
echo "🎯 期待値: 25本の個別楽曲動画"

echo ""
echo "🎓 Academy & Magic School Collection - 章別動画生成完了 ✨"