#!/bin/bash

# 🔥 Nostalgia & Campfire Collection - 騎士焚き火動画生成スクリプト
# 静止画から0.5倍速ループ動画を作成し、音声と合成

set -e

# 基本設定（スクリプトの場所から自動取得）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR"
INPUT_VIDEO="$BASE_DIR/10-assets/main-movie.mp4"
MASTER_AUDIO="$BASE_DIR/01-master/00-nostalgia-master.wav"
OUTPUT_DIR="$BASE_DIR/03-Individual-movie"
TEMP_VIDEO="$OUTPUT_DIR/nostalgia_campfire_slow_loop.mp4"
FINAL_VIDEO="$OUTPUT_DIR/00-nostalgia-campfire-master.mp4"

# ディレクトリ作成
mkdir -p "$OUTPUT_DIR"

echo "🔥 Nostalgia & Campfire Collection - 焚き火動画生成開始"
echo "📷 入力画像: $(basename "$INPUT_IMAGE")"
echo "🎵 音声ファイル: 00-nostalgia-master.wav"
echo ""

# 音声の長さを取得
echo "⏱️  音声ファイルの長さを確認中..."
DURATION=$(afinfo "$MASTER_AUDIO" | grep "estimated duration" | awk '{print $3}' | cut -d. -f1)
echo "🎵 音声の長さ: ${DURATION}秒 (約$((DURATION/60))分)"
echo ""

# Step 1: 静止画から0.5倍速動画作成（楽曲の長さでループ）
echo "🎬 Step 1: 静止画から0.25倍速ループ動画作成中..."
echo "   - 解像度: 1920x1080"
echo "   - フレームレート: 30fps"
echo "   - 速度: 0.25倍速 (setpts=4.0*PTS)"
echo "   - 長さ: ${DURATION}秒"

ffmpeg -y -loop 1 -i "$INPUT_IMAGE" \
       -vf "scale=1920:1080,setpts=4.0*PTS" \
       -c:v libx264 -pix_fmt yuv420p -r 30 \
       -t $DURATION \
       "$TEMP_VIDEO"

echo "✅ 0.5倍速動画完了: $(basename "$TEMP_VIDEO")"
echo ""

# Step 2: 音声と合成
echo "🎵 Step 2: 音声と動画を合成中..."
ffmpeg -y -i "$TEMP_VIDEO" \
       -i "$MASTER_AUDIO" \
       -c:v copy -c:a aac -shortest \
       "$FINAL_VIDEO"

echo "✅ 最終動画完了: $(basename "$FINAL_VIDEO")"
echo ""

# 結果確認
echo "📊 生成された動画情報:"
echo "📁 出力ディレクトリ: $OUTPUT_DIR"
ls -la "$OUTPUT_DIR/" | grep -E "\\.mp4$"

# 動画の詳細情報
echo ""
echo "🎬 最終動画の詳細:"
ffprobe -v quiet -print_format json -show_format -show_streams "$FINAL_VIDEO" | grep -E "duration|width|height|codec_name" | head -6

# 完了メッセージ
echo ""
echo "🎉 焚き火動画生成完了！"
echo "🔥 ファイル: $FINAL_VIDEO"
echo "⏱️  総処理時間: 約$(echo "scale=1; $DURATION/60" | bc)分の動画"
echo ""
echo "💡 使用方法:"
echo "   - YouTubeアップロード用: $FINAL_VIDEO"
echo "   - Complete Collection動画として使用可能"
echo "   - 0.5倍速でゆったりとした焚き火の雰囲気を演出"