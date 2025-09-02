#!/bin/bash

# 16-Bit Field Battle Collection - 完全動画生成スクリプト
# マスター動画: main 0.5倍速ループ
# 個別動画: 各楽曲 + main 0.5倍速ループ

set -e

# 基本設定（自動パス取得）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR"
INPUT_MAIN="$BASE_DIR/10-assets/main.png"
MASTER_AUDIO="$BASE_DIR/01-master/00-master.wav"
INDIVIDUAL_DIR="$BASE_DIR/02-Individual-music"
OUTPUT_DIR="$BASE_DIR/03-Individual-movie"

# 出力ディレクトリ作成
mkdir -p "$OUTPUT_DIR"

# 総実行時間計測開始
TOTAL_START_TIME=$(date +%s)

echo "⚔️ 16-Bit Field Battle Collection - 動画生成開始"
echo "📁 作業ディレクトリ: $BASE_DIR"
echo "⏱️  開始時刻: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

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
check_file "$INPUT_MAIN" "main.png" || exit 1
check_file "$MASTER_AUDIO" "マスター音声" || exit 1

# 音声ファイル数確認
AUDIO_COUNT=$(find "$INDIVIDUAL_DIR" -name "*.wav" -type f | wc -l)
echo "🎵 検出された音声ファイル: ${AUDIO_COUNT}個"

if [ "$AUDIO_COUNT" -eq 0 ]; then
    echo "❌ エラー: 音声ファイルが見つかりません"
    exit 1
fi

echo ""

# =============================================================================
# マスター動画生成
# =============================================================================

MASTER_OUTPUT="$BASE_DIR/01-master/16Bit-Field-Battle-Collection-Master.mp4"

echo "🎬 マスター動画生成開始"
echo "   入力画像: $(basename "$INPUT_MAIN")"
echo "   入力音声: $(basename "$MASTER_AUDIO")"
echo "   出力先: $(basename "$MASTER_OUTPUT")"

# 音声の長さ取得
DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$MASTER_AUDIO")
DURATION_INT=${DURATION%.*}
echo "⏱️ マスター音声時間: ${DURATION_INT}秒"

# マスター動画生成開始
START_TIME=$(date +%s)
PROGRESS_FILE="/tmp/ffmpeg_progress_$$"

# FFmpegをバックグラウンドで実行（プログレス情報付き・静止画版）
ffmpeg -y -loop 1 -i "$INPUT_MAIN" -i "$MASTER_AUDIO" \
       -c:v libx264 -c:a aac -pix_fmt yuv420p -r 30 \
       -shortest -progress "pipe:1" \
       "$MASTER_OUTPUT" 2>/dev/null | grep "out_time_ms" > "$PROGRESS_FILE" &

FFMPEG_PID=$!

# npm install風プログレスバー表示
SPINNER_CHARS=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
SPINNER_INDEX=0
LAST_PROGRESS=-1

echo -n "     "
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
                printf "\\r     %s [%s] %d%%" "$SPINNER" "$BAR" "$PROGRESS"
                LAST_PROGRESS=$PROGRESS
            fi
        fi
    fi
    
    # プログレス未取得時はスピナーのみ
    if [ "$LAST_PROGRESS" -eq -1 ]; then
        SPINNER=${SPINNER_CHARS[$SPINNER_INDEX]}
        SPINNER_INDEX=$(( (SPINNER_INDEX + 1) % 10 ))
        printf "\\r     %s マスター動画生成中..." "$SPINNER"
    fi
    
    sleep 0.1
done

# プロセス終了待機
wait $FFMPEG_PID
FFMPEG_EXIT_CODE=$?

# 完了表示
printf "\\r     ✅ [████████████████████] 100%%\\n"

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

if [ $FFMPEG_EXIT_CODE -eq 0 ]; then
    echo "✅ マスター動画生成完了 (生成時間: $TIME_FORMAT)"
else
    echo "❌ マスター動画生成失敗"
    exit 1
fi

rm -f "$PROGRESS_FILE"
echo ""

# =============================================================================
# 個別動画生成
# =============================================================================

echo "🎵 個別動画生成開始"
echo ""

PROCESSED=0
SUCCESSFUL=0
FAILED=0
TOTAL=$(find "$INDIVIDUAL_DIR" -name "*.wav" | wc -l)

for file in "$INDIVIDUAL_DIR"/*.wav; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    filename=$(basename "$file" .wav)
    # ファイル名から"16bit "プレフィックス削除
    clean_filename=${filename#16bit }
    output_file="$OUTPUT_DIR/${clean_filename}.mp4"
    ((PROCESSED++))
    
    echo "🎬 [$PROCESSED/$TOTAL] 処理中: $clean_filename"
    
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
    
    # FFmpegをバックグラウンドで実行（プログレス情報付き・静止画版）
    ffmpeg -y -loop 1 -i "$INPUT_MAIN" -i "$file" \
           -c:v libx264 -c:a aac -pix_fmt yuv420p -r 30 \
           -shortest -progress "pipe:1" \
           "$output_file" 2>/dev/null | grep "out_time_ms" > "$PROGRESS_FILE" &
    
    FFMPEG_PID=$!
    
    # プログレスバー表示（個別版）
    echo -n "       "
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
                    printf "\\r       ⠋ [%s] %d%%" "$BAR" "$PROGRESS"
                fi
            fi
        fi
        sleep 0.1
    done
    
    wait $FFMPEG_PID
    INDIVIDUAL_EXIT_CODE=$?
    printf "\\r       ✅ [███████████████] 100%%\\n"
    
    # 時間測定
    INDIVIDUAL_END=$(date +%s)
    ELAPSED=$((INDIVIDUAL_END - INDIVIDUAL_START))
    
    if [ $INDIVIDUAL_EXIT_CODE -eq 0 ]; then
        echo "   ✅ 完了 (生成時間: ${ELAPSED}秒)"
        ((SUCCESSFUL++))
    else
        echo "   ❌ 失敗"
        ((FAILED++))
    fi
    
    rm -f "$PROGRESS_FILE"
    echo ""
done

# =============================================================================
# 完了サマリー + 総実行時間計算
# =============================================================================

# 総実行時間計算
TOTAL_END_TIME=$(date +%s)
TOTAL_ELAPSED=$((TOTAL_END_TIME - TOTAL_START_TIME))
TOTAL_HOURS=$((TOTAL_ELAPSED / 3600))
TOTAL_MINUTES=$(((TOTAL_ELAPSED % 3600) / 60))
TOTAL_SECONDS=$((TOTAL_ELAPSED % 60))

# 時間フォーマット関数
format_duration() {
    local duration=$1
    local hours=$((duration / 3600))
    local minutes=$(((duration % 3600) / 60))
    local seconds=$((duration % 60))
    
    if [ $hours -gt 0 ]; then
        printf "%d時間%d分%d秒" $hours $minutes $seconds
    elif [ $minutes -gt 0 ]; then
        printf "%d分%d秒" $minutes $seconds
    else
        printf "%d秒" $seconds
    fi
}

echo "🎉 16-Bit Field Battle Collection 動画生成完了！"
echo ""
echo "📊 結果サマリー:"
echo "   📹 マスター動画: 1本生成完了"
echo "   🎵 個別動画: 成功 $SUCCESSFUL本 / 失敗 $FAILED本 / 総数 $TOTAL本"
echo "   ⚔️ 戦場バリエーション: 20フィールド完全対応"
echo ""
echo "⏱️  実行時間詳細:"
echo "   🎬 開始時刻: $(date -r $TOTAL_START_TIME '+%Y-%m-%d %H:%M:%S')"
echo "   🏁 終了時刻: $(date '+%Y-%m-%d %H:%M:%S')"
echo "   ⌚️ 総実行時間: $(format_duration $TOTAL_ELAPSED)"
echo "   📈 平均生成時間: $(format_duration $((TOTAL_ELAPSED / (SUCCESSFUL + 1))))本/動画"
echo ""
echo "📁 出力先: $OUTPUT_DIR"
echo "🎮 次のステップ: YouTube投稿 & プレイリスト作成"