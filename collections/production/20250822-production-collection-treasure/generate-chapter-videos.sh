#!/bin/bash

# 🏺 Treasure Collection - 章別動画生成バッチ処理
# HD-2D サムネイル (thambnail.png) を使用した5章分動画自動生成

set -e  # エラー時に停止

# 基本設定
BASE_DIR="/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/20250822-production-collection-treasure"
MUSIC_DIR="$BASE_DIR/02-Individual-music"
THUMBNAIL="$BASE_DIR/10-thumbnail/thambnail.png"
OUTPUT_DIR="$BASE_DIR/03-Individual-movie"

# 出力ディレクトリ作成
mkdir -p "$OUTPUT_DIR"

echo "🏺 Treasure Collection - 章別動画生成開始"
echo "📁 音楽ディレクトリ: $MUSIC_DIR"
echo "🎨 サムネイル: $THUMBNAIL"
echo "📹 出力先: $OUTPUT_DIR"
echo ""

# サムネイル存在確認
if [ ! -f "$THUMBNAIL" ]; then
    echo "❌ エラー: サムネイルが見つかりません: $THUMBNAIL"
    exit 1
fi

# 🗺️ 第1章: Discovery & Journey (楽曲 1-4)
echo "🗺️ 第1章: Discovery & Journey 動画生成中..."
CHAPTER1_FILES=(
    "01-Ancient Map Discovery.wav"
    "02-Journey to the Lost Temple.wav"  
    "03-First Glimpse of Ruins.wav"
    "04-Crossing the Sacred Threshold.wav"
)

for i in "${!CHAPTER1_FILES[@]}"; do
    file="${CHAPTER1_FILES[$i]}"
    track_num=$((i + 1))
    input_file="$MUSIC_DIR/$file"
    output_file="$OUTPUT_DIR/$(printf "%02d" $track_num)-${file%.wav}.mp4"
    
    if [ -f "$input_file" ]; then
        echo "  🎵 処理中: $file"
        ffmpeg -y -loop 1 -i "$THUMBNAIL" -i "$input_file" \
               -c:v libx264 -c:a aac -shortest \
               -pix_fmt yuv420p -r 30 \
               "$output_file"
        echo "  ✅ 完了: $(printf "%02d" $track_num)-${file%.wav}.mp4"
    else
        echo "  ❌ ファイルが見つかりません: $file"
    fi
done

# 🏛️ 第2章: Temple Exploration (楽曲 5-10)
echo ""
echo "🏛️ 第2章: Temple Exploration 動画生成中..."
CHAPTER2_FILES=(
    "05-Stone Corridor Echoes.wav"
    "06-Hall of Forgotten Kings.wav"
    "07-Hidden Chamber Revelation.wav" 
    "08-Guardian Statues Awakening.wav"
    "09-Underground River Crossing.wav"
    "10-Crystal Cave Illumination.wav"
)

for i in "${!CHAPTER2_FILES[@]}"; do
    file="${CHAPTER2_FILES[$i]}"
    track_num=$((i + 5))  # 5から開始
    input_file="$MUSIC_DIR/$file"
    output_file="$OUTPUT_DIR/$(printf "%02d" $track_num)-${file%.wav}.mp4"
    
    if [ -f "$input_file" ]; then
        echo "  🎵 処理中: $file"
        ffmpeg -y -loop 1 -i "$THUMBNAIL" -i "$input_file" \
               -c:v libx264 -c:a aac -shortest \
               -pix_fmt yuv420p -r 30 \
               "$output_file"
        echo "  ✅ 完了: $(printf "%02d" $track_num)-${file%.wav}.mp4"
    else
        echo "  ❌ ファイルが見つかりません: $file"
    fi
done

# 🧩 第3章: Trials & Mysteries (楽曲 11-15)
echo ""
echo "🧩 第3章: Trials & Mysteries 動画生成中..."
CHAPTER3_FILES=(
    "11-Ancient Symbol Decoding.wav"
    "12-Mechanical Puzzle Chamber.wav"
    "13-Trial of the Four Elements.wav"
    "14-Shadow Guardian Encounter.wav"
    "15-Ancient Wisdom Test.wav"
)

for i in "${!CHAPTER3_FILES[@]}"; do
    file="${CHAPTER3_FILES[$i]}"
    track_num=$((i + 11))  # 11から開始
    input_file="$MUSIC_DIR/$file"
    output_file="$OUTPUT_DIR/$(printf "%02d" $track_num)-${file%.wav}.mp4"
    
    if [ -f "$input_file" ]; then
        echo "  🎵 処理中: $file"
        ffmpeg -y -loop 1 -i "$THUMBNAIL" -i "$input_file" \
               -c:v libx264 -c:a aac -shortest \
               -pix_fmt yuv420p -r 30 \
               "$output_file"
        echo "  ✅ 完了: $(printf "%02d" $track_num)-${file%.wav}.mp4"
    else
        echo "  ❌ ファイルが見つかりません: $file"
    fi
done

# 💎 第4章: Treasure Discovery (楽曲 16-19)
echo ""
echo "💎 第4章: Treasure Discovery 動画生成中..."
CHAPTER4_FILES=(
    "16-Golden Door Unsealing.wav"
    "17-Treasure Chamber Entrance.wav"
    "18-Legendary Artifact Discovery.wav"
    "19-Ancient Knowledge Revelation.wav"
)

for i in "${!CHAPTER4_FILES[@]}"; do
    file="${CHAPTER4_FILES[$i]}"
    track_num=$((i + 16))  # 16から開始
    input_file="$MUSIC_DIR/$file"
    output_file="$OUTPUT_DIR/$(printf "%02d" $track_num)-${file%.wav}.mp4"
    
    if [ -f "$input_file" ]; then
        echo "  🎵 処理中: $file"
        ffmpeg -y -loop 1 -i "$THUMBNAIL" -i "$input_file" \
               -c:v libx264 -c:a aac -shortest \
               -pix_fmt yuv420p -r 30 \
               "$output_file"
        echo "  ✅ 完了: $(printf "%02d" $track_num)-${file%.wav}.mp4"
    else
        echo "  ❌ ファイルが見つかりません: $file"
    fi
done

# 🏃 第5章: Escape & Return (楽曲 20-22)
echo ""
echo "🏃 第5章: Escape & Return 動画生成中..."
CHAPTER5_FILES=(
    "20-Temple Collapse Warning.wav"
    "21-Race Against Time Escape.wav"
    "22-Victorious Return Journey.wav"
)

for i in "${!CHAPTER5_FILES[@]}"; do
    file="${CHAPTER5_FILES[$i]}"
    track_num=$((i + 20))  # 20から開始
    input_file="$MUSIC_DIR/$file"
    output_file="$OUTPUT_DIR/$(printf "%02d" $track_num)-${file%.wav}.mp4"
    
    if [ -f "$input_file" ]; then
        echo "  🎵 処理中: $file"
        ffmpeg -y -loop 1 -i "$THUMBNAIL" -i "$input_file" \
               -c:v libx264 -c:a aac -shortest \
               -pix_fmt yuv420p -r 30 \
               "$output_file"
        echo "  ✅ 完了: $(printf "%02d" $track_num)-${file%.wav}.mp4"
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
ls -la "$OUTPUT_DIR" | grep "Chapter.*\.mp4" | while read -r line; do
    echo "  $line"
done

echo ""
echo "🏺 Treasure Collection - 章別動画生成完了 ✨"