#!/bin/bash

# 16-Bit Adventure Collection - 完全動画生成スクリプト
# マスター動画: main 0.5倍速ループ
# 個別動画: 各楽曲 + main 0.5倍速ループ

set -e

# 基本設定（スクリプトの場所から自動取得）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR"
INPUT_MAIN="$BASE_DIR/10-assets/main.mp4"
THUMBNAIL="$BASE_DIR/10-assets/y-thambnail.png"
MASTER_AUDIO="$BASE_DIR/01-master/00-16bit-adventure-master.wav"
INDIVIDUAL_DIR="$BASE_DIR/02-Individual-music"
OUTPUT_DIR="$BASE_DIR/03-Individual-movie"

# ディレクトリ作成
mkdir -p "$OUTPUT_DIR"

echo "🎬 16-Bit Adventure Collection - 動画生成開始"
echo "📁 作業ディレクトリ: $BASE_DIR"

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
check_file "$INPUT_MAIN" "main.mp4" || exit 1
check_file "$MASTER_AUDIO" "マスター音声" || exit 1

# 個別楽曲数カウント
INDIVIDUAL_COUNT=$(find "$INDIVIDUAL_DIR" -name "*.wav" | wc -l)
echo "🎵 個別楽曲数: ${INDIVIDUAL_COUNT}曲"

if [ "$INDIVIDUAL_COUNT" -eq 0 ]; then
    echo "❌ エラー: 個別楽曲が見つかりません"
    exit 1
fi

# ====================
# マスター動画生成
# ====================
echo ""
echo "🎬 マスター動画生成開始"

# 音声の長さ取得
DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$MASTER_AUDIO")
DURATION_INT=${DURATION%.*}
echo "⏱️ マスター音声時間: ${DURATION_INT}秒"

# マスター動画生成（Nostalgia & Campfire パターン使用）
MASTER_OUTPUT="$BASE_DIR/01-master/00-16bit-adventure-master.mp4"

echo "🎬 マスター動画生成中... (時間がかかります)"

# 生成開始時刻を記録
START_TIME=$(date +%s)

# プログレス情報を一時ファイルに出力
PROGRESS_FILE="/tmp/ffmpeg_progress_$$"

# FFmpegをバックグラウンドで実行（プログレス情報付き）
ffmpeg -y -stream_loop -1 -i "$INPUT_MAIN" -i "$MASTER_AUDIO" \
       -vf "scale=1920:1080,setpts=2.0*PTS" \
       -c:v libx264 -c:a aac -pix_fmt yuv420p -r 30 \
       -shortest \
       -progress "pipe:1" \
       "$MASTER_OUTPUT" 2>/dev/null | grep "out_time_ms" > "$PROGRESS_FILE" &

# プロセスIDを取得
FFMPEG_PID=$!

# プログレスバー表示（npm install風）
SPINNER_CHARS=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
SPINNER_INDEX=0
LAST_PROGRESS=-1

while kill -0 $FFMPEG_PID 2>/dev/null; do
    if [ -f "$PROGRESS_FILE" ]; then
        # 最新のプログレス情報を取得
        LATEST_TIME=$(tail -1 "$PROGRESS_FILE" 2>/dev/null | grep "out_time_ms=" | cut -d= -f2)
        if [ -n "$LATEST_TIME" ] && [ "$LATEST_TIME" -gt 0 ] 2>/dev/null; then
            # プログレス計算（マイクロ秒をミリ秒に変換）
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
                
                # スピナーを取得
                SPINNER=${SPINNER_CHARS[$SPINNER_INDEX]}
                SPINNER_INDEX=$(( (SPINNER_INDEX + 1) % 10 ))
                
                # npm install風の表示
                printf "\r     %s [%s] %d%%" "$SPINNER" "$BAR" "$PROGRESS"
                
                LAST_PROGRESS=$PROGRESS
            fi
        fi
    fi
    
    # プログレスが変わってなくてもスピナーだけは回す
    if [ "$LAST_PROGRESS" -eq -1 ]; then
        SPINNER=${SPINNER_CHARS[$SPINNER_INDEX]}
        SPINNER_INDEX=$(( (SPINNER_INDEX + 1) % 10 ))
        printf "\r     %s マスター動画生成中..." "$SPINNER"
    fi
    
    sleep 0.1
done

# プロセス終了状態を確認
wait $FFMPEG_PID
FFMPEG_RESULT=$?

# 完了表示
printf "\r     ✅ [████████████████████] 100%%\n"

# 生成終了時刻を記録して時間を計算
END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))

# 時間フォーマット変換（秒 -> 時:分:秒）
HOURS=$((ELAPSED / 3600))
MINUTES=$(((ELAPSED % 3600) / 60))
SECONDS=$((ELAPSED % 60))

if [ $HOURS -gt 0 ]; then
    TIME_FORMAT="${HOURS}:$(printf "%02d" $MINUTES):$(printf "%02d" $SECONDS)"
else
    TIME_FORMAT="${MINUTES}:$(printf "%02d" $SECONDS)"
fi

# 一時ファイル削除
rm -f "$PROGRESS_FILE"

if [ $FFMPEG_RESULT -eq 0 ]; then
    echo "✅ マスター動画完成 (生成時間: $TIME_FORMAT)"
else
    echo "❌ マスター動画エラー (生成時間: $TIME_FORMAT)"
    exit 1
fi

# ====================
# 個別動画生成
# ====================
echo ""
echo "🎬 個別動画生成開始"

PROCESSED=0
SUCCESSFUL=0
FAILED=0
TOTAL=$INDIVIDUAL_COUNT

for file in "$INDIVIDUAL_DIR"/*.wav; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    filename=$(basename "$file" .wav)
    output_file="$OUTPUT_DIR/${filename}.mp4"
    ((PROCESSED++))
    
    echo "🎬 [$PROCESSED/$TOTAL] 処理中: $filename"
    
    # 音声ファイルの有効性確認
    if ! ffprobe -v quiet -show_format "$file" > /dev/null 2>&1; then
        echo "   ❌ エラー: 音声ファイルが破損しているか、サポートされていない形式です"
        ((FAILED++))
        echo ""
        continue
    fi
    
    # 楽曲の長さ取得（afinfoを使用）
    duration=$(afinfo "$file" | grep "estimated duration" | awk '{print $3}' | cut -d. -f1)
    if [ -z "$duration" ] || [ "$duration" -eq 0 ] 2>/dev/null; then
        echo "   ❌ エラー: 楽曲の長さを取得できません"
        ((FAILED++))
        echo ""
        continue
    fi
    
    minutes=$((duration/60))
    seconds=$((duration%60))
    echo "   ⏱️  楽曲長: ${duration}秒 (${minutes}:$(printf "%02d" $seconds))"
    
    # 個別処理時間測定開始
    INDIVIDUAL_START=$(date +%s)
    
    # プログレス情報を一時ファイルに出力
    PROGRESS_FILE="/tmp/ffmpeg_progress_individual_$$"
    
    # FFmpegをバックグラウンドで実行（プログレス情報付き）
    ffmpeg -y -stream_loop -1 -i "$INPUT_MAIN" -i "$file" \
           -vf "scale=1920:1080,setpts=2.0*PTS" -c:v libx264 -c:a aac \
           -pix_fmt yuv420p -r 30 -shortest \
           -progress "pipe:1" \
           "$output_file" 2>/dev/null | grep "out_time_ms" > "$PROGRESS_FILE" &
    
    # プロセスIDを取得
    FFMPEG_PID=$!
    
    # プログレスバー表示（npm install風・個別版）
    SPINNER_CHARS=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    SPINNER_INDEX=0
    LAST_PROGRESS=-1
    
    while kill -0 $FFMPEG_PID 2>/dev/null; do
        if [ -f "$PROGRESS_FILE" ]; then
            # 最新のプログレス情報を取得
            LATEST_TIME=$(tail -1 "$PROGRESS_FILE" 2>/dev/null | grep "out_time_ms=" | cut -d= -f2)
            if [ -n "$LATEST_TIME" ] && [ "$LATEST_TIME" -gt 0 ] 2>/dev/null; then
                # プログレス計算
                CURRENT_MS=$((LATEST_TIME / 1000))
                TARGET_MS=$((duration * 1000))
                if [ "$TARGET_MS" -gt 0 ]; then
                    PROGRESS=$((CURRENT_MS * 100 / TARGET_MS))
                    if [ "$PROGRESS" -gt 100 ]; then
                        PROGRESS=100
                    fi
                    
                    # プログレスバーを構築（15文字幅・個別版）
                    FILLED=$((PROGRESS * 15 / 100))
                    BAR=""
                    for i in $(seq 1 $FILLED); do
                        BAR="${BAR}█"
                    done
                    for i in $(seq $((FILLED + 1)) 15); do
                        BAR="${BAR}░"
                    done
                    
                    # スピナーを取得
                    SPINNER=${SPINNER_CHARS[$SPINNER_INDEX]}
                    SPINNER_INDEX=$(( (SPINNER_INDEX + 1) % 10 ))
                    
                    # npm install風の表示
                    printf "\r       %s [%s] %d%%" "$SPINNER" "$BAR" "$PROGRESS"
                    
                    LAST_PROGRESS=$PROGRESS
                fi
            fi
        fi
        
        # プログレスが変わってなくてもスピナーだけは回す
        if [ "$LAST_PROGRESS" -eq -1 ]; then
            SPINNER=${SPINNER_CHARS[$SPINNER_INDEX]}
            SPINNER_INDEX=$(( (SPINNER_INDEX + 1) % 10 ))
            printf "\r       %s %s 生成中..." "$SPINNER" "$filename"
        fi
        
        sleep 0.1
    done
    
    # プロセス終了状態を確認
    wait $FFMPEG_PID
    FFMPEG_EXIT_CODE=$?
    
    # 完了表示
    printf "\r       ✅ [███████████████] 100%%\n"
    
    # 個別処理時間測定終了
    INDIVIDUAL_END=$(date +%s)
    INDIVIDUAL_ELAPSED=$((INDIVIDUAL_END - INDIVIDUAL_START))
    
    # 時間フォーマット変換（秒 -> 分:秒）
    INDIVIDUAL_MINUTES=$((INDIVIDUAL_ELAPSED / 60))
    INDIVIDUAL_SECONDS=$((INDIVIDUAL_ELAPSED % 60))
    
    if [ $INDIVIDUAL_MINUTES -gt 0 ]; then
        INDIVIDUAL_TIME_FORMAT="${INDIVIDUAL_MINUTES}:$(printf "%02d" $INDIVIDUAL_SECONDS)"
    else
        INDIVIDUAL_TIME_FORMAT="${INDIVIDUAL_SECONDS}秒"
    fi
    
    # 一時ファイル削除
    rm -f "$PROGRESS_FILE"
    
    if [ $FFMPEG_EXIT_CODE -eq 0 ]; then
        echo "   ✅ 完了 (生成時間: $INDIVIDUAL_TIME_FORMAT)"
        ((SUCCESSFUL++))
    else
        echo "   ❌ エラー (生成時間: $INDIVIDUAL_TIME_FORMAT)"
        ((FAILED++))
    fi
    
    echo ""
done

# 完了サマリー
echo ""
echo "🎉 16-Bit Adventure Collection 動画生成完了！"
echo "📊 結果サマリー:"
echo "   📹 マスター動画: 1本生成完了"
echo "   🎵 個別動画: 成功 $SUCCESSFUL本 / 失敗 $FAILED本 / 総数 $TOTAL本"
echo "📁 出力先: $OUTPUT_DIR"
echo ""
echo "📋 生成された動画:"
ls -la "$OUTPUT_DIR"/*.mp4 | awk '{print "   📹", $9, "(" $5 "bytes)"}'
echo ""