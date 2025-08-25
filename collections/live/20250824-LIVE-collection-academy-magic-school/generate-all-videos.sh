#!/bin/bash

# 🎓 Academy & Magic School Collection - 全動画一括生成
# マスター + 個別25楽曲を一度に生成

set -e

echo "🎓 Academy & Magic School Collection - 全動画一括生成開始"
echo "=================================================="
echo ""

# 処理開始時刻記録
start_time=$(date +%s)
echo "⏰ 処理開始時刻: $(date)"
echo ""

# 1. マスター動画生成
echo "🎯 Step 1: マスター動画生成"
./generate-master-video-with-chapters

echo ""
echo "=================================================="
echo ""

# 2. 個別楽曲動画生成
echo "🎯 Step 2: 個別楽曲動画生成 (25本)"
./generate-chapter-videos.sh

echo ""
echo "=================================================="
echo ""

# 3. 生成結果まとめ
echo "🎉 全動画生成完了！"
echo ""
echo "📊 生成サマリー:"
echo "  🎬 マスター動画: 1本 (01-master/)"
echo "  🎵 個別楽曲: 25本 (03-Individual-movie/)"
echo "  合計: 26本の動画ファイル"
echo ""

# ファイル数確認
MASTER_COUNT=$(ls -1 01-master/*.mp4 2>/dev/null | wc -l || echo 0)
INDIVIDUAL_COUNT=$(ls -1 03-Individual-movie/*.mp4 2>/dev/null | wc -l || echo 0)

echo "✅ 実際の生成数:"
echo "  マスター: ${MASTER_COUNT}本"
echo "  個別楽曲: ${INDIVIDUAL_COUNT}本" 
echo "  合計: $((MASTER_COUNT + INDIVIDUAL_COUNT))本"

# 処理時間計算
end_time=$(date +%s)
duration=$((end_time - start_time))
echo ""
echo "⏱️ 処理時間情報:"
echo "  開始: $(date -r $start_time)"
echo "  完了: $(date -r $end_time)" 
echo "  処理時間: ${duration}秒"

# 処理速度計算（総音声時間: 1:37:51 = 5871秒）
if [ $duration -gt 0 ]; then
    speed=$(echo "scale=1; 5871 / $duration" | bc -l)
    echo "  処理速度: 約${speed}x リアルタイム"
fi

echo ""
echo "🎓 Academy & Magic School Collection 動画生成完全完了 ✨"
echo "🌟 25楽曲の魔法学院青春ストーリー、動画準備万端や！"