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

# FFmpegでの複数画像切り替えコマンド構築
FILTER_COMPLEX=""
INPUT_ARGS=""

# 各画像を入力として追加
for i in "${!IMAGES[@]}"; do
    INPUT_ARGS="$INPUT_ARGS -loop 1 -i \"${IMAGES[$i]}\""
done

# 音声入力追加
INPUT_ARGS="$INPUT_ARGS -i \"$MASTER_AUDIO\""

# フィルター構築（画像切り替えタイミング指定）
FILTER_COMPLEX="[0:v]trim=0:${CHAPTER_TIMES[1]},setpts=PTS-STARTPTS[v0];"

for i in 1; i < ${#CHAPTER_TIMES[@]}; do
    next_time=${CHAPTER_TIMES[$((i+1))]}
    if [ -z "$next_time" ]; then
        next_time="5871"  # 最後は総時間まで
    fi
    
    duration=$((next_time - CHAPTER_TIMES[i]))
    FILTER_COMPLEX="$FILTER_COMPLEX[$i:v]trim=0:$duration,setpts=PTS-STARTPTS[v$i];"
done

# 動画の結合
CONCAT_INPUTS=""
for i in "${!CHAPTER_TIMES[@]}"; do
    CONCAT_INPUTS="$CONCAT_INPUTS[v$i]"
done

FILTER_COMPLEX="$FILTER_COMPLEX${CONCAT_INPUTS}concat=n=${#CHAPTER_TIMES[@]}:v=1:a=0[outv]"

# 実際のFFmpegコマンド実行
eval "ffmpeg -y $INPUT_ARGS \
    -filter_complex \"$FILTER_COMPLEX\" \
    -map \"[outv]\" -map \"$((${#IMAGES[@]})):a\" \
    -c:v libx264 -c:a aac \
    -pix_fmt yuv420p -r 30 -shortest \
    \"$MASTER_DIR/00-academy-magic-master-chapters.mp4\""

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