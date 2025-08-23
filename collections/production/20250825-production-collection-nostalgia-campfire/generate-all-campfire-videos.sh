#!/bin/bash

# 🔥 Nostalgia & Campfire Collection - 全動画一括生成スクリプト
# マスター動画 + 個別楽曲動画22本を一括生成

set -e

# 基本設定
BASE_DIR="/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/20250825-production-collection-nostalgia-campfire"
INPUT_VIDEO="$BASE_DIR/10-assets/main-movie.mp4"
MASTER_AUDIO="$BASE_DIR/01-master/00-nostalgia-master.wav"
MUSIC_DIR="$BASE_DIR/02-Individual-music"
OUTPUT_DIR="$BASE_DIR/03-Individual-movie"

# ディレクトリ作成
mkdir -p "$OUTPUT_DIR"

echo "🔥 Nostalgia & Campfire Collection - 全動画一括生成開始"
echo "🎬 使用動画: $(basename "$INPUT_VIDEO")"
echo "🎵 マスター音声: 00-nostalgia-master.wav"
echo "📁 個別楽曲: $MUSIC_DIR"
echo "📁 出力先: $OUTPUT_DIR"
echo ""

# 動画ファイル存在・有効性確認
echo "🎬 動画ファイル確認中..."
if [ ! -f "$INPUT_VIDEO" ]; then
    echo "❌ エラー: 動画ファイルが見つかりません"
    echo "   パス: $INPUT_VIDEO"
    exit 1
fi

# ffprobeで動画ファイルの有効性確認
if ! ffprobe -v quiet -show_format "$INPUT_VIDEO" > /dev/null 2>&1; then
    echo "❌ エラー: 動画ファイルが破損しているか、サポートされていない形式です"
    echo "   パス: $INPUT_VIDEO"
    exit 1
fi
echo "✅ 動画ファイル: $(basename "$INPUT_VIDEO") - 有効"

# マスター音声存在・有効性確認  
echo "🎵 マスター音声ファイル確認中..."
if [ ! -f "$MASTER_AUDIO" ]; then
    echo "❌ エラー: マスター音声ファイルが見つかりません"
    echo "   パス: $MASTER_AUDIO"
    exit 1
fi

# ffprobeで音声ファイルの有効性確認
if ! ffprobe -v quiet -show_format "$MASTER_AUDIO" > /dev/null 2>&1; then
    echo "❌ エラー: 音声ファイルが破損しているか、サポートされていない形式です"
    echo "   パス: $MASTER_AUDIO"
    exit 1
fi
echo "✅ マスター音声ファイル: $(basename "$MASTER_AUDIO") - 有効"

# =============================================================================
# 🎬 STEP 1: マスター動画生成
# =============================================================================

echo "🎬 STEP 1: マスター動画生成開始"
MASTER_VIDEO="$OUTPUT_DIR/00-nostalgia-campfire-master.mp4"

# 音声の長さ取得
echo "⏱️  マスター音声の長さを確認中..."
MASTER_DURATION=$(afinfo "$MASTER_AUDIO" | grep "estimated duration" | awk '{print $3}' | cut -d. -f1)

# マスター音声の長さ有効性確認
if [ -z "$MASTER_DURATION" ] || [ "$MASTER_DURATION" -eq 0 ] 2>/dev/null; then
    echo "❌ エラー: マスター音声の長さを取得できません"
    echo "   パス: $MASTER_AUDIO"
    exit 1
fi

MASTER_MINUTES=$((MASTER_DURATION/60))
MASTER_SECONDS=$((MASTER_DURATION%60))
echo "🎵 マスター音声: ${MASTER_DURATION}秒 (${MASTER_MINUTES}:$(printf "%02d" $MASTER_SECONDS))"

# マスター動画生成
echo "🎥 マスター動画生成中... (時間がかかります)"

# 動画を音声の長さにループ・0.5倍速化
echo "   - 動画ループ・0.5倍速化中..."
echo "   - FFmpeg実行中（詳細出力表示）:"
ffmpeg -y -stream_loop -1 -i "$INPUT_VIDEO" \
       -i "$MASTER_AUDIO" \
       -vf "scale=1920:1080,setpts=2.0*PTS" \
       -c:v libx264 -c:a aac \
       -pix_fmt yuv420p -r 30 -shortest \
       -progress pipe:1 \
       "$MASTER_VIDEO"

echo "✅ マスター動画完了: $(basename "$MASTER_VIDEO")"
echo ""

# =============================================================================
# 🎵 STEP 2: 個別楽曲動画生成
# =============================================================================

echo "🎵 STEP 2: 個別楽曲動画生成開始"

# 処理対象楽曲確認
MUSIC_COUNT=0
echo "📊 個別楽曲一覧:"
for music_file in "$MUSIC_DIR"/*.wav; do
    if [ -f "$music_file" ]; then
        echo "   $(basename "$music_file")"
        ((MUSIC_COUNT++))
    fi
done

if [ $MUSIC_COUNT -eq 0 ]; then
    echo "❌ エラー: 個別楽曲ファイルが見つかりません"
    echo "   ディレクトリ: $MUSIC_DIR"
    exit 1
fi

echo "📊 総楽曲数: ${MUSIC_COUNT}曲"
echo ""

# 個別動画生成処理
PROCESSED=0
SUCCESSFUL=0
FAILED=0

for music_file in "$MUSIC_DIR"/*.wav; do
    if [ ! -f "$music_file" ]; then
        continue
    fi
    
    # ファイル名処理
    music_basename=$(basename "$music_file" .wav)
    output_video="$OUTPUT_DIR/${music_basename}.mp4"
    
    # 進行状況
    ((PROCESSED++))
    echo "🎬 [$PROCESSED/$MUSIC_COUNT] 処理中: $music_basename"
    
    # 音声ファイルの有効性確認
    if ! ffprobe -v quiet -show_format "$music_file" > /dev/null 2>&1; then
        echo "   ❌ エラー: 音声ファイルが破損しているか、サポートされていない形式です"
        echo "   パス: $music_file"
        ((FAILED++))
        echo ""
        continue
    fi
    
    # 楽曲の長さ取得
    duration=$(afinfo "$music_file" | grep "estimated duration" | awk '{print $3}' | cut -d. -f1)
    if [ -z "$duration" ] || [ "$duration" -eq 0 ] 2>/dev/null; then
        echo "   ❌ エラー: 楽曲の長さを取得できません"
        ((FAILED++))
        echo ""
        continue
    fi
    
    minutes=$((duration/60))
    seconds=$((duration%60))
    echo "   ⏱️  楽曲長: ${duration}秒 (${minutes}:$(printf "%02d" $seconds))"
    
    # 既存ファイルスキップ
    if [ -f "$output_video" ]; then
        echo "   ⚠️  既存ファイルをスキップ"
        ((SUCCESSFUL++))
        echo ""
        continue
    fi
    
    # 個別動画生成
    echo "   🎥 0.5倍速動画生成中..."
    echo "   📺 FFmpeg実行:"
    if ffmpeg -y -stream_loop -1 -i "$INPUT_VIDEO" \
              -i "$music_file" \
              -vf "scale=1920:1080,setpts=2.0*PTS" \
              -c:v libx264 -c:a aac \
              -pix_fmt yuv420p -r 30 -shortest \
              -progress pipe:1 \
              "$output_video"; then
        echo "   ✅ 完了"
        ((SUCCESSFUL++))
    else
        echo "   ❌ エラー"
        ((FAILED++))
    fi
    
    echo ""
done

# =============================================================================
# 📊 結果サマリー
# =============================================================================

echo "📊 生成結果サマリー:"
echo ""
echo "🎬 マスター動画:"
echo "   ✅ 00-nostalgia-campfire-master.mp4 (${MASTER_MINUTES}:$(printf "%02d" $MASTER_SECONDS))"
echo ""
echo "🎵 個別楽曲動画:"
echo "   ✅ 成功: ${SUCCESSFUL}個"
echo "   ❌ 失敗: ${FAILED}個"
echo "   📊 総処理: ${PROCESSED}個"

# 生成ファイル一覧
echo ""
echo "📁 生成されたファイル一覧:"
TOTAL_FILES=0
TOTAL_SIZE=0
for video_file in "$OUTPUT_DIR"/*.mp4; do
    if [ -f "$video_file" ]; then
        file_size=$(stat -f%z "$video_file" 2>/dev/null || echo "0")
        file_size_mb=$((file_size / 1024 / 1024))
        echo "   $(basename "$video_file") (${file_size_mb}MB)"
        ((TOTAL_FILES++))
        ((TOTAL_SIZE += file_size_mb))
    fi
done

echo ""
echo "💾 ディスク使用量:"
echo "   📊 総ファイル数: ${TOTAL_FILES}個"
echo "   💽 総サイズ: ${TOTAL_SIZE}MB (約$(echo "scale=1; $TOTAL_SIZE/1024" | bc 2>/dev/null || echo "?")GB)"

# 完了メッセージ
echo ""
if [ $FAILED -eq 0 ]; then
    echo "🎉 全ての動画生成が完了しました！"
    echo ""
    echo "💡 次のステップ:"
    echo "   1. 生成された動画をプレビュー確認"
    echo "   2. YouTubeにアップロード"
    echo "   3. 概要欄・サムネイル設定"
else
    echo "⚠️  一部エラーがありましたが、メイン処理は完了"
fi

echo ""
echo "🔥 Nostalgia & Campfire Collection 動画生成完了 🔥"