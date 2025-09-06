#!/bin/bash

# 16-Bit Village & Town Collection ver.2 - 完全動画生成スクリプト v5.3
# マスター動画: main 静止画 + マスター音声
# 個別動画: 各楽曲 + main 静止画

set -e

# 基本設定（自動パス取得）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR"
INPUT_MAIN="$BASE_DIR/10-assets/16bit-village-main.png"  # 静止画対応
MASTER_AUDIO="$BASE_DIR/01-master/00-master.wav"
INDIVIDUAL_DIR="$BASE_DIR/02-Individual-music"
OUTPUT_DIR="$BASE_DIR/03-Individual-movie"

# 総実行時間計測開始
TOTAL_START_TIME=$(date +%s)

echo "🏰 16-Bit Village & Town Collection ver.2 - 動画生成開始"
echo "📅 実行日時: $(date)"
echo "📁 作業ディレクトリ: $BASE_DIR"
echo ""

mkdir -p "$OUTPUT_DIR"

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

echo "📁 ファイル存在確認中..."
check_file "$INPUT_MAIN" "main.png" || exit 1
check_file "$MASTER_AUDIO" "マスター音声" || exit 1

# 音声の長さ取得
DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$MASTER_AUDIO")
DURATION_INT=${DURATION%.*}
echo "⏱️ マスター音声時間: ${DURATION_INT}秒 ($(($DURATION_INT/60)):$(printf "%02d" $(($DURATION_INT%60))))"

echo ""
echo "🎬 === マスター動画生成開始 ==="

# マスター動画生成開始
START_TIME=$(date +%s)
PROGRESS_FILE="/tmp/ffmpeg_progress_$$"

# マスター動画出力先（01-masterフォルダ）
MASTER_OUTPUT="$BASE_DIR/01-master/16-Bit-Village-Town-Collection-ver2-Master.mp4"

echo "📤 出力先: $(basename "$MASTER_OUTPUT")"

# FFmpegをバックグラウンドで実行（プログレス情報付き・静止画対応）
ffmpeg -y -loop 1 -i "$INPUT_MAIN" -i "$MASTER_AUDIO" \
       -c:v libx264 -c:a aac -pix_fmt yuv420p -r 30 \
       -shortest -progress "pipe:1" \
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

echo ""
echo "🎵 === 個別動画生成開始 ==="

# 個別ファイル処理
PROCESSED=0
SUCCESSFUL=0
FAILED=0
TOTAL=$(find "$INDIVIDUAL_DIR" -name "*.wav" | wc -l)

echo "📊 処理予定: $TOTAL 個の楽曲"
echo ""

for file in "$INDIVIDUAL_DIR"/*.wav; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    filename=$(basename "$file" .wav)
    # ファイル名から"16bit "プレフィックス削除（存在する場合）
    clean_filename=${filename#16bit }
    # " (Remix)16bit"サフィックス削除
    clean_filename=${clean_filename% \(Remix\)16bit}
    # 末尾の"16bit"削除
    clean_filename=${clean_filename%16bit}
    
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
    
    # FFmpegをバックグラウンドで実行（プログレス情報付き・静止画対応）
    ffmpeg -y -loop 1 -i "$INPUT_MAIN" -i "$file" \
           -c:v libx264 -c:a aac -pix_fmt yuv420p -r 30 \
           -shortest -progress "pipe:1" \
           "$output_file" 2>/dev/null | grep "out_time_ms" > "$PROGRESS_FILE" &
    
    FFMPEG_PID=$!
    
    # プログレスバー表示（個別版）
    SPINNER_INDEX=0
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
                    
                    SPINNER=${SPINNER_CHARS[$SPINNER_INDEX]}
                    SPINNER_INDEX=$(( (SPINNER_INDEX + 1) % 10 ))
                    printf "\r       %s [%s] %d%%" "$SPINNER" "$BAR" "$PROGRESS"
                fi
            fi
        else
            SPINNER=${SPINNER_CHARS[$SPINNER_INDEX]}
            SPINNER_INDEX=$(( (SPINNER_INDEX + 1) % 10 ))
            printf "\r       %s 処理中..." "$SPINNER"
        fi
        sleep 0.1
    done
    
    wait $FFMPEG_PID
    FFMPEG_EXIT_CODE=$?
    
    if [ $FFMPEG_EXIT_CODE -eq 0 ]; then
        printf "\r       ✅ [███████████████] 100%%\n"
        
        # 時間測定
        INDIVIDUAL_END=$(date +%s)
        ELAPSED=$((INDIVIDUAL_END - INDIVIDUAL_START))
        echo "   ✅ 完了 (生成時間: ${ELAPSED}秒)"
        ((SUCCESSFUL++))
    else
        printf "\r       ❌ [███████████████] ERROR\n"
        echo "   ❌ 失敗: FFmpegエラー (終了コード: $FFMPEG_EXIT_CODE)"
        ((FAILED++))
    fi
    
    rm -f "$PROGRESS_FILE"
    echo ""
done

echo "🏆 === 生成完了サマリー ==="
echo "📊 結果: 成功 $SUCCESSFUL / 失敗 $FAILED / 総数 $TOTAL"

# 総実行時間計算・表示
TOTAL_END_TIME=$(date +%s)
TOTAL_ELAPSED=$((TOTAL_END_TIME - TOTAL_START_TIME))
TOTAL_HOURS=$((TOTAL_ELAPSED / 3600))
TOTAL_MINUTES=$(((TOTAL_ELAPSED % 3600) / 60))
TOTAL_SECONDS=$((TOTAL_ELAPSED % 60))

echo "⏱️  総実行時間: ${TOTAL_HOURS}時間${TOTAL_MINUTES}分${TOTAL_SECONDS}秒"
if [ $SUCCESSFUL -gt 0 ]; then
    echo "📈 平均生成時間: $((TOTAL_ELAPSED / SUCCESSFUL))秒/動画"
fi

echo ""
echo "🎉 16-Bit Village & Town Collection ver.2 動画生成完了！"
echo "📊 結果サマリー:"
echo "   📹 マスター動画: 1本生成完了"
echo "   🎵 個別動画: 成功 $SUCCESSFUL本 / 失敗 $FAILED本 / 総数 $TOTAL本"
echo "📁 出力先:"
echo "   📹 マスター: $BASE_DIR/01-master/"
echo "   🎵 個別: $OUTPUT_DIR"
echo ""
echo "🚀 次のステップ:"
echo "   1. YouTube投稿用ファイル確認"
echo "   2. サムネイル生成 (Midjourney)"
echo "   3. 概要欄設定 (youtube-descriptions.md参照)"
echo ""

# 生成されたファイル一覧表示
echo "📋 生成ファイル一覧:"
echo "📹 マスター動画:"
if [ -f "$MASTER_OUTPUT" ]; then
    echo "   ✅ $(basename "$MASTER_OUTPUT")"
else
    echo "   ❌ マスター動画生成失敗"
fi

echo "🎵 個別動画 (最初の5ファイル):"
ls "$OUTPUT_DIR"/*.mp4 2>/dev/null | head -5 | while read file; do
    echo "   ✅ $(basename "$file")"
done

if [ $TOTAL -gt 5 ]; then
    echo "   ... 他 $((TOTAL-5))ファイル"
fi