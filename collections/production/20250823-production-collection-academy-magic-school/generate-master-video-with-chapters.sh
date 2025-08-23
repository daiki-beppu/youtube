#!/bin/bash

# 🎓 Academy & Magic School Collection - マスター動画生成（章別画像切り替え版）
# 各章に合わせてサムネイルを切り替える高度版

set -e

# 基本設定
BASE_DIR="/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/20250823-production-collection-academy-magic-school"
MUSIC_DIR="$BASE_DIR/02-Individual-music"
THUMBNAIL_DIR="$BASE_DIR/10-thumbnail"
MASTER_DIR="$BASE_DIR/01-master"
TEMP_DIR="/tmp/academy_master_chapters"

# ディレクトリ作成
mkdir -p "$MASTER_DIR"
mkdir -p "$TEMP_DIR"

echo "🎓 Academy & Magic School Collection - 章別画像切り替えマスター動画生成開始"
echo "📁 サムネイルディレクトリ: $THUMBNAIL_DIR"
echo "📹 出力先: $MASTER_DIR"
echo ""

# 必要な画像ファイルの確認（実際のファイル名に合わせて修正）
IMAGES=(
    "$THUMBNAIL_DIR/Academy-Life-Begins.png"
    "$THUMBNAIL_DIR/Learning-Growth.png"
    "$THUMBNAIL_DIR/Adventures-Challenges.png"
    "$THUMBNAIL_DIR/Mastery-Leadership.png"
    "$THUMBNAIL_DIR/Beyond-Academy.png"
)

# 画像が存在しない場合はメイン画像を使用
MAIN_IMAGE="$THUMBNAIL_DIR/thamnail-base.png"
if [ ! -f "$MAIN_IMAGE" ]; then
    MAIN_IMAGE="$THUMBNAIL_DIR/Academy-Life-Begins.png"
    if [ ! -f "$MAIN_IMAGE" ]; then
        echo "❌ エラー: メインサムネイルが見つかりません"
        exit 1
    fi
fi

# 各章の画像が存在しない場合はメイン画像をコピー
for i in "${!IMAGES[@]}"; do
    if [ ! -f "${IMAGES[$i]}" ]; then
        echo "⚠️  章別画像が見つかりません: $(basename "${IMAGES[$i]}")"
        echo "   メイン画像を使用します: $(basename "$MAIN_IMAGE")"
        IMAGES[$i]="$MAIN_IMAGE"
    fi
done

# マスター音声ファイル確認
MASTER_AUDIO="$MASTER_DIR/00-academy-magic-master.wav"
if [ ! -f "$MASTER_AUDIO" ]; then
    echo "❌ エラー: マスター音声が見つかりません: $MASTER_AUDIO"
    exit 1
fi

echo "🎵 マスター音声: 00-academy-magic-master.wav"
echo ""

# 章別タイムスタンプ（秒）
# 第1章: 0:00-14:20 (0-860秒)
# 第2章: 18:24-37:15 (1104-2235秒) 
# 第3章: 37:15-59:40 (2235-3580秒)
# 第4章: 59:40-1:19:58 (3580-4798秒)
# 第5章: 1:19:58-1:37:51 (4798-5871秒)

CHAPTER_TIMES=(
    "0"      # 第1章開始
    "1104"   # 第2章開始
    "2235"   # 第3章開始
    "3580"   # 第4章開始
    "4798"   # 第5章開始
)

CHAPTER_NAMES=(
    "Academy Life Begins"
    "Learning & Growth"
    "Adventures & Challenges"
    "Mastery & Leadership"
    "Beyond Academy"
)

echo "🎬 章別画像切り替えマスター動画生成中..."

# 画像切り替え版の実装
echo "🎬 章別画像切り替え版を作成中..."

# 各章の長さを計算（秒）
CHAPTER_DURATIONS=(
    "$((${CHAPTER_TIMES[1]} - ${CHAPTER_TIMES[0]}))"  # 第1章: 1104秒
    "$((${CHAPTER_TIMES[2]} - ${CHAPTER_TIMES[1]}))"  # 第2章: 1131秒
    "$((${CHAPTER_TIMES[3]} - ${CHAPTER_TIMES[2]}))"  # 第3章: 1345秒
    "$((${CHAPTER_TIMES[4]} - ${CHAPTER_TIMES[3]}))"  # 第4章: 1218秒
    "$((5871 - ${CHAPTER_TIMES[4]}))"                 # 第5章: 1073秒
)

# 各章の動画セグメントを作成
SEGMENT_FILES=()
for i in "${!IMAGES[@]}"; do
    chapter_start=${CHAPTER_TIMES[$i]}
    chapter_duration=${CHAPTER_DURATIONS[$i]}
    segment_file="$TEMP_DIR/chapter_$i.mp4"
    
    echo "📹 第$((i+1))章セグメント作成: ${CHAPTER_NAMES[$i]} (${chapter_duration}秒)"
    
    ffmpeg -y -loop 1 -i "${IMAGES[$i]}" \
           -i "$MASTER_AUDIO" -ss $chapter_start -t $chapter_duration \
           -c:v libx264 -c:a aac -pix_fmt yuv420p -r 30 \
           "$segment_file"
    
    SEGMENT_FILES+=("$segment_file")
done

# セグメントリストファイル作成
CONCAT_LIST="$TEMP_DIR/concat_list.txt"
echo "# 章別結合リスト" > "$CONCAT_LIST"
for segment in "${SEGMENT_FILES[@]}"; do
    echo "file '$segment'" >> "$CONCAT_LIST"
done

# セグメントを結合
ffmpeg -y -f concat -safe 0 -i "$CONCAT_LIST" \
       -c copy \
       "$MASTER_DIR/00-academy-magic-master-chapters.mp4"

echo ""
echo "✅ 章別画像切り替えマスター動画完了: 00-academy-magic-master-chapters.mp4"

# 代替案：シンプルな方法（画像切り替えなし、高品質版）
echo ""
echo "🎬 シンプル版マスター動画も生成中..."
ffmpeg -y -loop 1 -i "$MAIN_IMAGE" \
       -i "$MASTER_AUDIO" \
       -c:v libx264 -c:a aac \
       -pix_fmt yuv420p -r 30 -shortest \
       "$MASTER_DIR/00-academy-magic-master.mp4"

echo "✅ シンプル版マスター動画完了: 00-academy-magic-master.mp4"

# 時間情報表示
echo ""
echo "⏱️ マスター動画情報:"
afinfo "$MASTER_AUDIO" | grep "estimated duration"

echo ""
echo "📁 生成されたマスターファイル:"
ls -la "$MASTER_DIR/"

# クリーンアップ
rm -rf "$TEMP_DIR"

echo ""
echo "🎉 マスター動画生成完了！"
echo "🌟 章別画像切り替え版: 00-academy-magic-master-chapters.mp4"
echo "🎯 シンプル版: 00-academy-magic-master.mp4"