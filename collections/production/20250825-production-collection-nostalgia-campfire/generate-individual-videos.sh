#!/bin/bash

# 🔥 Nostalgia & Campfire Collection - 個別楽曲動画一括生成スクリプト
# 騎士焚き火画像 + 各楽曲 → 0.5倍速個別動画作成

set -e

# 基本設定
BASE_DIR="/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/20250825-production-collection-nostalgia-campfire"
INPUT_IMAGE="/Users/macmini/Downloads/u5217824488_a_weary_knight_lost_in_thought_beside_a_small_cam_8eb5eb4e-e11e-4208-ba56-a26bb9f0d396_0.png"
MUSIC_DIR="$BASE_DIR/02-Individual-music"
OUTPUT_DIR="$BASE_DIR/03-Individual-movie"

# ディレクトリ作成
mkdir -p "$OUTPUT_DIR"

echo "🔥 Nostalgia & Campfire Collection - 個別楽曲動画一括生成開始"
echo "📷 使用画像: $(basename "$INPUT_IMAGE")"
echo "📁 楽曲ディレクトリ: $MUSIC_DIR"
echo "📁 出力ディレクトリ: $OUTPUT_DIR"
echo ""

# 処理対象楽曲を確認
echo "🎵 処理対象楽曲一覧:"
MUSIC_COUNT=0
for music_file in "$MUSIC_DIR"/*.wav; do
    if [ -f "$music_file" ]; then
        echo "   $(basename "$music_file")"
        ((MUSIC_COUNT++))
    fi
done

echo ""
echo "📊 総楽曲数: ${MUSIC_COUNT}曲"
echo ""

# 各楽曲の動画生成
PROCESSED=0
FAILED=0

for music_file in "$MUSIC_DIR"/*.wav; do
    if [ ! -f "$music_file" ]; then
        continue
    fi
    
    # ファイル名取得（拡張子なし）
    music_basename=$(basename "$music_file" .wav)
    output_video="$OUTPUT_DIR/${music_basename}.mp4"
    
    # 進行状況表示
    ((PROCESSED++))
    echo "🎬 [$PROCESSED/$MUSIC_COUNT] 処理中: $music_basename"
    
    # 音声の長さ取得
    duration=$(afinfo "$music_file" | grep "estimated duration" | awk '{print $3}' | cut -d. -f1)
    minutes=$((duration/60))
    seconds=$((duration%60))
    
    echo "   ⏱️  楽曲長: ${duration}秒 (${minutes}:$(printf "%02d" $seconds))"
    
    # 既存ファイルチェック
    if [ -f "$output_video" ]; then
        echo "   ⚠️  既存ファイルをスキップ: $(basename "$output_video")"
        echo ""
        continue
    fi
    
    # 動画生成
    echo "   🎥 0.5倍速動画生成中..."
    if ffmpeg -y -loop 1 -i "$INPUT_IMAGE" \
              -i "$music_file" \
              -vf "scale=1920:1080,setpts=2.0*PTS" \
              -c:v libx264 -c:a aac \
              -pix_fmt yuv420p -r 30 -shortest \
              "$output_video" > /dev/null 2>&1; then
        echo "   ✅ 完了: $(basename "$output_video")"
    else
        echo "   ❌ エラー: $music_basename"
        ((FAILED++))
    fi
    
    echo ""
done

# 結果サマリー
echo "📊 処理結果サマリー:"
echo "   ✅ 成功: $((PROCESSED - FAILED))個の動画"
echo "   ❌ 失敗: ${FAILED}個の動画"
echo "   📁 総ファイル数: $(ls -1 "$OUTPUT_DIR"/*.mp4 2>/dev/null | wc -l)個"

# 生成されたファイル一覧
echo ""
echo "📁 生成された動画ファイル一覧:"
ls -la "$OUTPUT_DIR"/*.mp4 2>/dev/null | while read line; do
    echo "   $line"
done

# 完了メッセージ
echo ""
if [ $FAILED -eq 0 ]; then
    echo "🎉 全ての個別動画生成完了！"
else
    echo "⚠️  一部エラーがありましたが、処理完了"
fi

echo ""
echo "💡 使用方法:"
echo "   - 各動画はYouTube個別投稿用"
echo "   - 0.5倍速でゆったりとした雰囲気"
echo "   - 騎士が物思いにふける焚き火シーン"
echo "   - ファイル名は楽曲名と同じ"

# ディスク使用量確認
echo ""
echo "💾 ディスク使用量:"
du -sh "$OUTPUT_DIR" 2>/dev/null || echo "   確認できませんでした"