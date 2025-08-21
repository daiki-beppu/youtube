#!/bin/bash

# 🏺 Treasure Collection - 全動画一括生成
# マスター + 個別22楽曲 + 章別5本を一度に生成

set -e

echo "🏺 Treasure Collection - 全動画一括生成開始"
echo "=================================================="
echo ""

# 1. マスター動画生成
echo "🎯 Step 1: マスター動画生成"
./generate-master-video.sh

echo ""
echo "=================================================="
echo ""

# 2. 個別楽曲動画生成
echo "🎯 Step 2: 個別楽曲動画生成 (22本)"
./generate-chapter-videos.sh

echo ""
echo "=================================================="
echo ""

# 3. 生成結果まとめ
echo "🎉 全動画生成完了！"
echo ""
echo "📊 生成サマリー:"
echo "  🎬 マスター動画: 1本 (01-master/)"
echo "  🎵 個別楽曲: 22本 (03-Individual-movie/)"
echo "  合計: 23本の動画ファイル"
echo ""

# ファイル数確認
MASTER_COUNT=$(ls -1 01-master/*.mp4 2>/dev/null | wc -l || echo 0)
INDIVIDUAL_COUNT=$(ls -1 03-Individual-movie/*.mp4 2>/dev/null | grep -E "^[0-9]{2}-" | wc -l || echo 0)

echo "✅ 実際の生成数:"
echo "  マスター: ${MASTER_COUNT}本"
echo "  個別楽曲: ${INDIVIDUAL_COUNT}本" 
echo "  合計: $((MASTER_COUNT + INDIVIDUAL_COUNT))本"

echo ""
echo "🏺 Treasure Collection 動画生成完全完了 ✨"
echo "🎮 HD-2D サムネイルによる美麗な宝探し冒険動画、準備万端や！"