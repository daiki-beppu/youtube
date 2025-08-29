#!/bin/bash

# Royal Castle Collection - 完全動画生成スクリプト
# マスター動画: 静止画サムネイル + マスター音声
# 個別動画: 静止画サムネイル + 各楽曲音声

set -e

# 基本設定（自動パス取得）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR"
ASSETS_DIR="$BASE_DIR/10-assets"
MASTER_AUDIO="$BASE_DIR/01-master/00-royal-castle-master.wav"
INDIVIDUAL_DIR="$BASE_DIR/02-Individual-music"
OUTPUT_DIR="$BASE_DIR/03-Individual-movie"

# エリア別画像設定（Royal Castle Collection）
AREA1_IMAGE="$ASSETS_DIR/01.png"  # 🏰 王室中枢エリア（Track 1-6）
AREA2_IMAGE="$ASSETS_DIR/02.png"  # 💃 社交文化エリア（Track 7-12）
AREA3_IMAGE="$ASSETS_DIR/03.png"  # ⚔️ 守護騎士エリア（Track 13-18）
AREA4_IMAGE="$ASSETS_DIR/04.png"  # 🌙 日常憩いエリア（Track 19-24）

echo "🏰 Royal Castle Collection - 動画生成開始"
echo "================================================"

# 出力ディレクトリ作成
mkdir -p "$OUTPUT_DIR"

# 楽曲番号からエリア画像を選択する関数
get_area_image() {
    local track_number="$1"
    
    if [ "$track_number" -ge 1 ] && [ "$track_number" -le 6 ]; then
        echo "$AREA1_IMAGE"  # 🏰 王室中枢エリア
    elif [ "$track_number" -ge 7 ] && [ "$track_number" -le 12 ]; then
        echo "$AREA2_IMAGE"  # 💃 社交文化エリア
    elif [ "$track_number" -ge 13 ] && [ "$track_number" -le 18 ]; then
        echo "$AREA3_IMAGE"  # ⚔️ 守護騎士エリア
    elif [ "$track_number" -ge 19 ] && [ "$track_number" -le 24 ]; then
        echo "$AREA4_IMAGE"  # 🌙 日常憩いエリア
    else
        echo "$AREA1_IMAGE"  # デフォルト
    fi
}

# エリア名を取得する関数
get_area_name() {
    local track_number="$1"
    
    if [ "$track_number" -ge 1 ] && [ "$track_number" -le 6 ]; then
        echo "🏰 王室中枢エリア"
    elif [ "$track_number" -ge 7 ] && [ "$track_number" -le 12 ]; then
        echo "💃 社交文化エリア"
    elif [ "$track_number" -ge 13 ] && [ "$track_number" -le 18 ]; then
        echo "⚔️ 守護騎士エリア"
    elif [ "$track_number" -ge 19 ] && [ "$track_number" -le 24 ]; then
        echo "🌙 日常憩いエリア"
    else
        echo "🏰 王室中枢エリア"
    fi
}

# ファイル存在確認関数
check_file() {
    local file="$1"
    local name="$2"
    
    if [ ! -f "$file" ]; then
        echo "❌ エラー: ${name}が見つかりません"
        echo "   パス: $file"
        return 1
    fi
    
    if ! ffprobe -v quiet -show_format "$file" > /dev/null 2>&1; then
        echo "❌ エラー: ${name}が破損しているか、サポートされていない形式です"
        return 1
    fi
    
    echo "✅ ${name}: $(basename "$file") - 有効"
    return 0
}

# 必要ファイル確認
echo "📁 ファイル存在確認中..."
check_file "$AREA1_IMAGE" "王室中枢エリア画像" || exit 1
check_file "$AREA2_IMAGE" "社交文化エリア画像" || exit 1
check_file "$AREA3_IMAGE" "守護騎士エリア画像" || exit 1
check_file "$AREA4_IMAGE" "日常憩いエリア画像" || exit 1
check_file "$MASTER_AUDIO" "マスター音声" || exit 1

# マスター動画生成
echo ""
echo "🎬 マスター動画生成中..."
MASTER_OUTPUT="$OUTPUT_DIR/00-royal-castle-master.mp4"

# 音声の長さ取得
DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$MASTER_AUDIO")
DURATION_INT=${DURATION%.*}
echo "⏱️ マスター音声時間: ${DURATION_INT}秒 ($(($DURATION_INT/60)):$(printf "%02d" $(($DURATION_INT%60))))"

# マスター動画生成開始
START_TIME=$(date +%s)
PROGRESS_FILE="/tmp/ffmpeg_progress_$$"

# マスター動画用は代表画像（01.png）を使用
MASTER_THUMBNAIL="$AREA1_IMAGE"

# FFmpegをバックグラウンドで実行（プログレス情報付き）
ffmpeg -y -loop 1 -i "$MASTER_THUMBNAIL" -i "$MASTER_AUDIO" \
       -c:v libx264 -c:a aac -shortest \
       -progress "pipe:1" \
       "$MASTER_OUTPUT" 2>/dev/null | grep "out_time_ms" > "$PROGRESS_FILE" &

FFMPEG_PID=$!

# npm install風プログレスバー表示
SPINNER_CHARS=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
SPINNER_INDEX=0
LAST_PROGRESS=-1

while kill -0 $FFMPEG_PID 2>/dev/null; do
    if [ -f "$PROGRESS_FILE" ]; then
        LATEST_TIME=$(tail -1 "$PROGRESS_FILE" 2>/dev/null | grep "out_time_ms=" | cut -d= -f2)
        if [ -n "$LATEST_TIME" ] && [ "$LATEST_TIME" -gt 0 ] 2>/dev/null; then
            CURRENT_MS=$((LATEST_TIME / 1000))
            TARGET_MS=$((DURATION_INT * 1000))
            if [ "$TARGET_MS" -gt 0 ]; then
                PROGRESS=$((CURRENT_MS * 100 / TARGET_MS))
                if [ "$PROGRESS" -gt 100 ]; then
                    PROGRESS=100
                fi
                
                # プログレスバーを構築（20文字幅）
                FILLED=$((PROGRESS * 20 / 100))
                BAR=""
                for i in $(seq 1 $FILLED); do
                    BAR="${BAR}█"
                done
                for i in $(seq $((FILLED + 1)) 20); do
                    BAR="${BAR}░"
                done
                
                SPINNER=${SPINNER_CHARS[$SPINNER_INDEX]}
                SPINNER_INDEX=$(( (SPINNER_INDEX + 1) % 10 ))
                
                # npm install風の表示
                printf "\r     %s [%s] %d%%" "$SPINNER" "$BAR" "$PROGRESS"
                LAST_PROGRESS=$PROGRESS
            fi
        fi
    fi
    
    # プログレス未取得時はスピナーのみ
    if [ "$LAST_PROGRESS" -eq -1 ]; then
        SPINNER=${SPINNER_CHARS[$SPINNER_INDEX]}
        SPINNER_INDEX=$(( (SPINNER_INDEX + 1) % 10 ))
        printf "\r     %s マスター動画生成中..." "$SPINNER"
    fi
    
    sleep 0.1
done

# 完了表示
printf "\r     ✅ [████████████████████] 100%%\n"

# 時間測定・表示
END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))
MINUTES=$((ELAPSED / 60))
SECONDS=$((ELAPSED % 60))

if [ $MINUTES -gt 0 ]; then
    TIME_FORMAT="${MINUTES}:$(printf "%02d" $SECONDS)"
else
    TIME_FORMAT="${SECONDS}秒"
fi

echo "✅ マスター動画生成完了 (生成時間: $TIME_FORMAT)"
rm -f "$PROGRESS_FILE"

# 個別動画生成
echo ""
echo "🎵 個別楽曲動画生成中..."
PROCESSED=0
SUCCESSFUL=0
FAILED=0
TOTAL=$(find "$INDIVIDUAL_DIR" -name "*.wav" | wc -l | tr -d ' ')

for file in "$INDIVIDUAL_DIR"/*.wav; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    filename=$(basename "$file" .wav)
    output_file="$OUTPUT_DIR/${filename}.mp4"
    ((PROCESSED++))
    
    # 楽曲番号を抽出（01-Royal Throne Room.wav → 1）
    track_number=$(echo "$filename" | sed 's/^0*\([0-9]*\)-.*/\1/')
    
    # エリア画像とエリア名を取得
    area_image=$(get_area_image "$track_number")
    area_name=$(get_area_name "$track_number")
    
    echo "🎬 [$PROCESSED/$TOTAL] 処理中: $filename"
    echo "   🖼️  使用画像: $(basename "$area_image") ($area_name)"
    
    # 楽曲の長さ取得（afinfoを使用）
    duration=$(afinfo "$file" | grep "estimated duration" | awk '{print $3}' | cut -d. -f1)
    if [ -z "$duration" ] || [ "$duration" -eq 0 ] 2>/dev/null; then
        echo "   ❌ エラー: 楽曲の長さを取得できません"
        ((FAILED++))
        continue
    fi
    
    minutes=$((duration/60))
    seconds=$((duration%60))
    echo "   ⏱️  楽曲長: ${duration}秒 (${minutes}:$(printf "%02d" $seconds))"
    
    # 個別処理時間測定開始
    INDIVIDUAL_START=$(date +%s)
    PROGRESS_FILE="/tmp/ffmpeg_progress_individual_$$"
    
    # FFmpegをバックグラウンドで実行（エリア別画像を使用）
    ffmpeg -y -loop 1 -i "$area_image" -i "$file" \
           -c:v libx264 -c:a aac -shortest \
           -progress "pipe:1" \
           "$output_file" 2>/dev/null | grep "out_time_ms" > "$PROGRESS_FILE" &
    
    FFMPEG_PID=$!
    
    # プログレスバー表示（個別版）
    while kill -0 $FFMPEG_PID 2>/dev/null; do
        if [ -f "$PROGRESS_FILE" ]; then
            LATEST_TIME=$(tail -1 "$PROGRESS_FILE" 2>/dev/null | grep "out_time_ms=" | cut -d= -f2)
            if [ -n "$LATEST_TIME" ] && [ "$LATEST_TIME" -gt 0 ] 2>/dev/null; then
                CURRENT_MS=$((LATEST_TIME / 1000))
                TARGET_MS=$((duration * 1000))
                if [ "$TARGET_MS" -gt 0 ]; then
                    PROGRESS=$((CURRENT_MS * 100 / TARGET_MS))
                    if [ "$PROGRESS" -gt 100 ]; then
                        PROGRESS=100
                    fi
                    FILLED=$((PROGRESS * 15 / 100))
                    BAR=""
                    for i in $(seq 1 $FILLED); do
                        BAR="${BAR}█"
                    done
                    for i in $(seq $((FILLED + 1)) 15); do
                        BAR="${BAR}░"
                    done
                    printf "\r       ⠋ [%s] %d%%" "$BAR" "$PROGRESS"
                fi
            fi
        fi
        sleep 0.1
    done
    
    wait $FFMPEG_PID
    EXIT_CODE=$?
    
    if [ $EXIT_CODE -eq 0 ]; then
        printf "\r       ✅ [███████████████] 100%%\n"
        
        # 時間測定
        INDIVIDUAL_END=$(date +%s)
        ELAPSED=$((INDIVIDUAL_END - INDIVIDUAL_START))
        echo "   ✅ 完了 (生成時間: ${ELAPSED}秒)"
        ((SUCCESSFUL++))
    else
        printf "\r       ❌ エラーが発生しました\n"
        echo "   ❌ 失敗 (FFmpegエラー)"
        ((FAILED++))
    fi
    
    rm -f "$PROGRESS_FILE"
    echo ""
done

# 最終結果表示
echo "================================================"
echo "🎉 Royal Castle Collection 動画生成完了！"
echo ""
echo "📊 結果サマリー:"
echo "   📹 マスター動画: 1本生成完了"
echo "   🎵 個別動画: 成功 $SUCCESSFUL本 / 失敗 $FAILED本 / 総数 $TOTAL本"
echo "   📁 出力先: $OUTPUT_DIR"
echo ""

if [ $FAILED -gt 0 ]; then
    echo "⚠️  $FAILED本の動画生成に失敗しました。ログを確認してください。"
else
    echo "✨ すべての動画が正常に生成されました！"
fi

echo "================================================"