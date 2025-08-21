#!/bin/bash

# 🏺 Treasure Collection - マスター動画生成
# 全22楽曲を統合したマスター動画を生成

set -e

# 基本設定
BASE_DIR="/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production/20250822-production-collection-treasure"
MUSIC_DIR="$BASE_DIR/02-Individual-music"
THUMBNAIL="$BASE_DIR/10-thumbnail/thambnail.png"
MASTER_DIR="$BASE_DIR/01-master"
TEMP_DIR="/tmp/treasure_master"

# ディレクトリ作成
mkdir -p "$MASTER_DIR"
mkdir -p "$TEMP_DIR"

echo "🏺 Treasure Collection - マスター動画生成開始"
echo "📁 音楽ディレクトリ: $MUSIC_DIR"
echo "🎨 サムネイル: $THUMBNAIL"
echo "📹 出力先: $MASTER_DIR"
echo ""

# サムネイル存在確認
if [ ! -f "$THUMBNAIL" ]; then
    echo "❌ エラー: サムネイルが見つかりません: $THUMBNAIL"
    exit 1
fi

# 既存マスター音声ファイル確認
MASTER_AUDIO="$MASTER_DIR/00-treasure-master.wav"
if [ ! -f "$MASTER_AUDIO" ]; then
    echo "❌ エラー: マスター音声が見つかりません: $MASTER_AUDIO"
    echo "先に音声ファイルを作成してください"
    exit 1
fi

echo "🎵 既存マスター音声を使用: 00-treasure-master.wav"

echo ""
echo "🎬 マスター動画生成中..."
ffmpeg -y -loop 1 -i "$THUMBNAIL" \
       -i "$MASTER_AUDIO" \
       -c:v libx264 -c:a aac \
       -pix_fmt yuv420p -r 30 -shortest \
       "$MASTER_DIR/00-treasure-master.mp4"
echo "✅ マスター動画完了: 00-treasure-master.mp4"

# 時間情報表示
echo ""
echo "⏱️ マスター動画情報:"
afinfo "$MASTER_DIR/00-treasure-master.wav" | grep "estimated duration"

# クリーンアップ
rm -rf "$TEMP_DIR"

echo ""
echo "📁 生成されたマスターファイル:"
ls -la "$MASTER_DIR/"

echo ""
echo "🎉 マスター動画生成完了！"
echo "🏺 完全版Treasure Collection (1:46:21) 準備完了 ✨"