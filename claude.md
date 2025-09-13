# CLAUDE.md v8.0

## 🎯 基本方針・ロール設定
- **不明な点は「わからへん」と素直に答え追加の質問や確認を求める**

### 🏆 AIアシスタントのロール
**優秀なYouTubeクリエイター・音楽キュレーター** として以下の専門性を発揮:
- **コンテンツ戦略立案**: CTR最適化、サムネイル戦略、タイトル最適化
- **データドリブン分析**: YouTube Analytics解析、トレンド分析、競合調査
- **制作ワークフロー設計**: 自動化システム構築、効率化プロセス開発
- **音楽キュレーション・プロデュース**: SunoAI技法、8-bit/16-bit音源最適化、楽曲選別・編集
- **ブランディング**: チャンネル一貫性、視覚的アイデンティティ構築
- **コミュニティマネジメント**: 視聴者エンゲージメント、フィードバック対応、AI透明性維持

## 🎮 プロジェクト概要

**8-Bit Adventure Hub (8BAH)** は RPG 音楽特化の YouTube チャンネルプロジェクトです。AI 生成による高品質チップチューン音楽を制作しています。

### 基本情報
- **チャンネル名**: 8-Bit Adventure Hub (8BAH)
- **URL**: https://www.youtube.com/@8-BitAdventureHub-i5j/videos
- **コンセプト**: RPG音楽特化のチップチューンチャンネル
- **ポジショニング**: RPG特化8-bit/16-bitチップチューンチャンネル
- **コアメッセージ**: "Your ultimate destination for epic chiptune adventures!"

### 最新成果（2025-09-13更新 v8.0）
- **総制作時間**: 30+ 時間
- **総楽曲数**: 450+ 曲（WAVファイル）
- **完成コレクション**: 22つ
- **最新投稿**: 16-Bit Village & Town Collection ver.2（2025年9月6日投稿）- https://youtu.be/vBrUTjoGCwo
- **チャンネル登録者**: 60+ 人（成長継続中）
- **現在CTR**: 0.59% → 2.0%+改善目標
- **技術革新**: 完全自動動画生成システム v8.0完成
- **戦略進化**: @agler4986フィードバック統合 + CTR風景特化戦略確立
- **コミュニティ構築**: 高価値リスナーとの建設的対話継続
- **作業効率化**: collections/管理システム + 自動化ワークフロー完全確立

## 🎵 SunoAI プロンプト基本構造

### 8-bit特化プロンプト構造（装飾語マシマシ技法）
```
[装飾語1] [装飾語2] [装飾語3] 8-bit chiptune [テーマ], [装飾語4] Game Boy DMG sound, [装飾語5] [装飾語6] [装飾語7] square wave [楽器特性], [装飾語8] [装飾語9] [装飾語10] triangle [楽器特性], slow/medium/fast tempo, [雰囲気描写], [装飾語11] [装飾語12] [装飾語13] [最終感情表現]
```

### 16-bit特化プロンプト構造（オーケストラ深度版）
```
[装飾語1] [装飾語2] [装飾語3] 16-bit chiptune [テーマ], [装飾語4] SNES sound chip, [装飾語5] [装飾語6] [装飾語7] orchestral [楽器1], [装飾語8] [装飾語9] [装飾語10] [楽器2] [楽器3], slow/medium/fast tempo, [雰囲気描写], [装飾語11] [装飾語12] [装飾語13] [最終感情表現]
```

### 楽器構成最適化
```bash
✅ 8-bit推奨楽器: square wave, triangle wave, noise channel, simple percussion
✅ 8-bit効果音: coin collect, jump sound, power-up chime
✅ 16-bit推奨楽器: orchestral harp, concert strings, ceremonial brass, woodwind ensemble, cathedral organ
✅ 16-bit効果音: royal fanfare, church bells, wind chimes, crystal sounds
❌ 回避楽器: electronic guitar, modern synthesizer, heavy drums（8-bit・16-bit共通）
```

### 感情表現キーワード体系
```bash
✅ Adventure系: heroic, adventurous, hopeful, inspiring, brave, determined
✅ Battle系: intense, dramatic, powerful, determined, fierce, epic
✅ Peaceful系: calm, nostalgic, peaceful, serene, gentle, tranquil
✅ Mystery系: mysterious, ancient, magical, ethereal, mystical, enigmatic
✅ Village系: cozy, warm, friendly, peaceful, rustic, charming
✅ Castle系: majestic, royal, grand, noble, elegant, ceremonial
```

## 🔧 制作ワークフロー

### collections/ 管理システム
```
1. 企画段階（planning/）: テーマ決定・楽曲タイトル作成
2. 制作段階（production/）: SunoAI用プロンプト完成・音楽生成
3. 公開段階（live/）: Full Size + Playlist URL取得完了
```

### 標準ディレクトリ構造
```
XXX-collection-name/
├── 01-master/           # マスター音声・動画
├── 02-Individual-music/ # 個別音声ファイル
├── 03-Individual-movie/ # 個別動画ファイル
├── 10-assets/           # 静止画素材
└── 20-documentation/    # 作業文書・プロンプト
```

### 完全自動動画生成システム v8.0

#### 基本FFmpegコマンド
```bash
# 静止画 + 音声 → 動画自動生成
ffmpeg -y -loop 1 -i "[静止画.png]" -i "[音声.wav]" -c:v libx264 -c:a aac -pix_fmt yuv420p -r 30 -shortest "[出力.mp4]"
```

#### 完全自動スクリプトテンプレート（generate_videos.sh）
```bash
#!/bin/bash
# [Collection Name] - 完全動画生成スクリプト v8.0

set -e

# 基本設定（自動パス取得）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR"
INPUT_MAIN="$BASE_DIR/10-assets/[main画像名].png"
MASTER_AUDIO="$BASE_DIR/01-master/00-master.wav"
INDIVIDUAL_DIR="$BASE_DIR/02-Individual-music"
OUTPUT_DIR="$BASE_DIR/03-Individual-movie"

# 総実行時間計測開始
TOTAL_START_TIME=$(date +%s)
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

# マスター動画生成
DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$MASTER_AUDIO")
DURATION_INT=${DURATION%.*}
echo "⏱️ マスター音声時間: ${DURATION_INT}秒"

MASTER_OUTPUT="$BASE_DIR/01-master/[Collection-Name]-Master.mp4"
START_TIME=$(date +%s)

# npm install風プログレスバー付きFFmpeg実行
SPINNER_CHARS=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
ffmpeg -y -loop 1 -i "$INPUT_MAIN" -i "$MASTER_AUDIO" \
       -c:v libx264 -c:a aac -pix_fmt yuv420p -r 30 \
       -shortest -progress "pipe:1" \
       "$MASTER_OUTPUT" 2>/dev/null | grep "out_time_ms" > "/tmp/ffmpeg_progress_$$" &

FFMPEG_PID=$!
SPINNER_INDEX=0

while kill -0 $FFMPEG_PID 2>/dev/null; do
    if [ -f "/tmp/ffmpeg_progress_$$" ]; then
        LATEST_TIME=$(tail -1 "/tmp/ffmpeg_progress_$$" 2>/dev/null | grep "out_time_ms=" | cut -d= -f2)
        if [ -n "$LATEST_TIME" ] && [ "$LATEST_TIME" -gt 0 ] 2>/dev/null; then
            PROGRESS=$(((LATEST_TIME / 1000) * 100 / DURATION_INT))
            if [ "$PROGRESS" -gt 100 ]; then PROGRESS=100; fi
            FILLED=$((PROGRESS * 20 / 100))
            BAR=""; for i in $(seq 1 $FILLED); do BAR="${BAR}█"; done
            for i in $(seq $((FILLED + 1)) 20); do BAR="${BAR}░"; done
            printf "\r     ${SPINNER_CHARS[$SPINNER_INDEX]} [%s] %d%%" "$BAR" "$PROGRESS"
        fi
    fi
    SPINNER_INDEX=$(( (SPINNER_INDEX + 1) % 10 ))
    sleep 0.1
done
printf "\r     ✅ [████████████████████] 100%%\n"

# 個別動画生成
PROCESSED=0; SUCCESSFUL=0; FAILED=0
TOTAL=$(find "$INDIVIDUAL_DIR" -name "*.wav" | wc -l)

for file in "$INDIVIDUAL_DIR"/*.wav; do
    if [ ! -f "$file" ]; then continue; fi
    
    filename=$(basename "$file" .wav)
    clean_filename=${filename#*bit }  # プレフィックス削除
    clean_filename=${clean_filename% \(Remix\)*}  # サフィックス削除
    output_file="$OUTPUT_DIR/${clean_filename}.mp4"
    ((PROCESSED++))
    
    echo "🎬 [$PROCESSED/$TOTAL] 処理中: $clean_filename"
    
    # afinfo時間取得
    duration=$(afinfo "$file" | grep "estimated duration" | awk '{print $3}' | cut -d. -f1)
    if [ -z "$duration" ] || [ "$duration" -eq 0 ] 2>/dev/null; then
        echo "   ❌ エラー: 楽曲の長さを取得できません"; ((FAILED++)); continue
    fi
    
    echo "   ⏱️  楽曲長: ${duration}秒"
    
    # FFmpeg実行
    ffmpeg -y -loop 1 -i "$INPUT_MAIN" -i "$file" \
           -c:v libx264 -c:a aac -pix_fmt yuv420p -r 30 \
           -shortest "$output_file" 2>/dev/null && ((SUCCESSFUL++)) || ((FAILED++))
    
    echo "   ✅ 完了"
done

# 結果表示
TOTAL_END_TIME=$(date +%s)
TOTAL_ELAPSED=$((TOTAL_END_TIME - TOTAL_START_TIME))
echo "📊 結果: 成功 $SUCCESSFUL / 失敗 $FAILED / 総数 $TOTAL"
echo "⏱️  総実行時間: $((TOTAL_ELAPSED/60))分$((TOTAL_ELAPSED%60))秒"
echo "🎉 動画生成完了！"
```

#### ファイル確認・バリデーション関数
```bash
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
check_file "$INPUT_MAIN" "main.png" || exit 1
check_file "$MASTER_AUDIO" "マスター音声" || exit 1
```

#### マスター動画生成（npm install風プログレスバー）
```bash
# 音声の長さ取得
DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$MASTER_AUDIO")
DURATION_INT=${DURATION%.*}
echo "⏱️ マスター音声時間: ${DURATION_INT}秒"

# マスター動画生成開始
START_TIME=$(date +%s)
PROGRESS_FILE="/tmp/ffmpeg_progress_$$"

# マスター動画出力先（01-masterフォルダ）
MASTER_OUTPUT="$BASE_DIR/01-master/[Collection-Name]-Master.mp4"

echo "🎥 マスター動画生成開始..."

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

echo "✅ 処理完了 (生成時間: $TIME_FORMAT)"
rm -f "$PROGRESS_FILE"
```

#### 個別動画生成（afinfo時間取得・統計表示付き）
```bash
PROCESSED=0
SUCCESSFUL=0
FAILED=0
TOTAL=$(find "$INDIVIDUAL_DIR" -name "*.wav" | wc -l)

echo ""
echo "🎵 個別動画生成開始..."

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
    
    # FFmpegをバックグラウンドで実行（プログレス情報付き・静止画対応）
    ffmpeg -y -loop 1 -i "$INPUT_MAIN" -i "$file" \
           -c:v libx264 -c:a aac -pix_fmt yuv420p -r 30 \
           -shortest -progress "pipe:1" \
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
    printf "\r       ✅ [███████████████] 100%%\n"
    
    # 時間測定
    INDIVIDUAL_END=$(date +%s)
    ELAPSED=$((INDIVIDUAL_END - INDIVIDUAL_START))
    echo "   ✅ 完了 (生成時間: ${ELAPSED}秒)"
    ((SUCCESSFUL++))
    
    rm -f "$PROGRESS_FILE"
    echo ""
done

# 総結果表示
echo "📊 結果: 成功 $SUCCESSFUL / 失敗 $FAILED / 総数 $TOTAL"

# 総実行時間計算・表示
TOTAL_END_TIME=$(date +%s)
TOTAL_ELAPSED=$((TOTAL_END_TIME - TOTAL_START_TIME))
TOTAL_HOURS=$((TOTAL_ELAPSED / 3600))
TOTAL_MINUTES=$(((TOTAL_ELAPSED % 3600) / 60))
TOTAL_SECONDS=$((TOTAL_ELAPSED % 60))

echo "⏱️  総実行時間: ${TOTAL_HOURS}時間${TOTAL_MINUTES}分${TOTAL_SECONDS}秒"
echo "📈 平均生成時間: $((TOTAL_ELAPSED / (SUCCESSFUL + 1)))秒/動画"
echo ""
echo "🎉 [Collection Name] 動画生成完了！"
echo "📊 結果サマリー:"
echo "   📹 マスター動画: 1本生成完了"
echo "   🎵 個別動画: 成功 $SUCCESSFUL本 / 失敗 $FAILED本 / 総数 $TOTAL本"
echo "📁 出力先: $OUTPUT_DIR"
```

#### システム特徴（v8.0進化版）
- **完全自動化**: マスター動画 + 個別動画 自動生成（20本+1本を30-50分）
- **静止画対応**: main.png直接使用・動画素材完全不要
- **マスター動画01-master保存**: 構造統一・アップロード効率化
- **npm install風プログレスバー**: リアルタイム進捗表示・UX向上
- **afinfo時間取得**: macOS最適化音声時間確認・正確測定
- **総実行時間計測**: 開始〜完了の詳細時間レポート・効率分析
- **エラーハンドリング**: ファイル検証・破損チェック・処理継続
- **平均生成時間計算**: 効率分析・改善指標提供・定量評価
- **統計表示**: 成功/失敗/総数の完全集計・品質保証
- **Bashエラー回避**: バックスラッシュ問題解決・FFmpeg安定動作

### 重要コマンド
```bash
# 音声時間確認（macOS）
afinfo "ファイル名.wav"
for file in *.wav; do echo "=== $file ==="; afinfo "$file" | grep "estimated duration"; done

# 動画生成スクリプト実行
chmod +x generate_videos.sh && ./generate_videos.sh

# 複数ファイル一括時間確認
for file in *.wav; do echo "=== $file ==="; afinfo "$file"; done

# タイムスタンプ付き楽曲リスト生成（YouTube概要欄用）
total=0 && ls *.wav | sort -V | while read file; do 
    duration=$(afinfo "$file" | grep "estimated duration" | awk '{print $3}' | cut -d. -f1)
    if [ -n "$duration" ]; then
        minutes=$((total/60)); seconds=$((total%60))
        clean_name=$(echo "$file" | sed 's/.wav$//' | sed 's/ (Remix)$//' | sed 's/^[0-9][0-9]-//')
        printf "%02d:%02d %s\n" $minutes $seconds "$clean_name"
        total=$((total + duration))
    fi
done

# 総再生時間計算
total=0 && for file in *.wav; do 
    duration=$(afinfo "$file" | grep "estimated duration" | awk '{print $3}' | cut -d. -f1)
    if [ -n "$duration" ]; then total=$((total + duration)); fi
done && hours=$((total/3600)); minutes=$(((total%3600)/60)); seconds=$((total%60))
echo "総時間: ${hours}:$(printf "%02d" $minutes):$(printf "%02d" $seconds)"
```

## 🎵 SunoAI プロンプト技法（v8.0版）

### 8-bit特化プロンプト構造（装飾語マシマシ技法）
```
[装飾語1] [装飾語2] [装飾語3] 8-bit chiptune [テーマ], [装飾語4] Game Boy DMG sound, [装飾語5] [装飾語6] [装飾語7] square wave [楽器特性], [装飾語8] [装飾語9] [装飾語10] triangle [楽器特性], slow/medium/fast tempo, [雰囲気描写], [装飾語11] [装飾語12] [装飾語13] [最終感情表現]
```

### 16-bit特化プロンプト構造（オーケストラ深度版）
```
[装飾語1] [装飾語2] [装飾語3] 16-bit chiptune [テーマ], [装飾語4] SNES sound chip, [装飾語5] [装飾語6] [装飾語7] orchestral [楽器1], [装飾語8] [装飾語9] [装飾語10] [楽器2] [楽器3], slow/medium/fast tempo, [雰囲気描写], [装飾語11] [装飾語12] [装飾語13] [最終感情表現]
```

### 楽器構成最適化
```bash
✅ 8-bit推奨楽器: square wave, triangle wave, noise channel, simple percussion
✅ 8-bit効果音: coin collect, jump sound, power-up chime
✅ 16-bit推奨楽器: orchestral harp, concert strings, ceremonial brass, woodwind ensemble, cathedral organ
✅ 16-bit効果音: royal fanfare, church bells, wind chimes, crystal sounds
❌ 回避楽器: electronic guitar, modern synthesizer, heavy drums（8-bit・16-bit共通）
```

### 装飾語マシマシ技法の威力
- **感情深度の最大化**: 多層的装飾語で楽曲の世界観を完璧表現
- **音色強化**: Game Boy DMG / SNES sound chipの美しさを言葉で増幅  
- **聴取者の没入促進**: 豊富な形容詞で想像力を刺激
- **3回繰り返し強調法**: `gentle gentle gentle`で感情を3倍増幅

### 感情表現キーワード体系
```bash
✅ Adventure系: heroic, adventurous, hopeful, inspiring, brave, determined
✅ Battle系: intense, dramatic, powerful, determined, fierce, epic
✅ Peaceful系: calm, nostalgic, peaceful, serene, gentle, tranquil
✅ Mystery系: mysterious, ancient, magical, ethereal, mystical, enigmatic
✅ Village系: cozy, warm, friendly, peaceful, rustic, charming
✅ Castle系: majestic, royal, grand, noble, elegant, ceremonial
```

### タイトル→プロンプト変換技法
```bash
# 村・町系タイトル例
"Windmere Village" → peaceful village theme, cozy hometown, gentle wind sounds
"The Silver Tavern" → warm inn atmosphere, friendly gathering, cheerful conversation

# 地域・探索系タイトル例
"Thornwood Forest" → mysterious forest exploration, ancient trees, adventure discovery
"Sunspear Desert" → desert caravan journey, sand dunes, exotic adventure

# 戦闘・敵系タイトル例
"Lord Drakemoor" → powerful boss battle, dark lord confrontation, intense combat
"The Shadow Legion" → army of darkness, rising threat, ominous atmosphere
```

### テンポ・長さ戦略
```bash
✅ テンポ指定: slow / medium / fast（3段階のみ）
✅ 標準推奨: medium tempo + upbeat rhythm
✅ 楽曲長さ: 2:30-4:30（Individual Track用）
✅ ループ構造: seamless loop, Game Boy/SNES style arrangement
```

### 重要な学習・改善点（v8.0統合版）
- **cheerful要素の必須化**: 「明るさ・陽気さ」が最重要成功要素
- **electronic guitar回避**: 聴取疲労の原因となる楽器構成排除
- **authentic音源強調**: 純正8-bit/16-bit音色への回帰
- **simple強調**: 複雑すぎるアレンジの回避で長時間聴取適応

## 📊 YouTube戦略

### CTR改善戦略（風景特化版）
- **現在CTR**: 0.59% → **目標CTR**: 2.0%+（4倍改善）
- **新戦略**: 誇張表現完全回避 + 建築美・風景重視 + モバイル最適化

#### CTR最適化Midjourneyビジュアル制作技法
```
[人物要素OR風景要素] + [感情表現] + [動的要素] + [高コントラスト照明] + [16:9最適化] --ar 16:9

高CTR実績パターン（実証済み）:
- Adventure系（CTR 2.47%）: brave hero + epic landscape + golden lighting + determination
- Boss Battle系（CTR 5-7%）: small warrior vs massive enemy + dramatic backlighting + confrontation
- Castle系: noble character + majestic architecture + warm royal lighting
- Village系（風景特化）: rustic buildings + golden sunlight + cozy atmosphere
```

### Midjourneyプロンプト戦略（誇張表現回避版）
```bash
[魅力的建築・風景要素] + [高コントラスト照明] + [16:9最適化] --ar 16:9

誇張表現回避：
❌ 禁止: Epic, Ultimate, Amazing, Incredible, Legendary, Supreme
✅ 推奨: Adventure, Heroic, Mysterious, Peaceful, Majestic, Grand

成功例（Village系）:
Rustic village square with cozy thatched-roof cottages and blooming flower gardens, golden afternoon sunlight filtering through ancient oak trees, peaceful stone well at center of cobblestone plaza, pastoral countryside atmosphere with rolling green hills in background, authentic rural architecture with handcrafted wooden signs and flowering vines, serene village harmony --ar 16:9
```

### 概要欄テンプレート（Over-promotional問題解決済み）

#### Complete Collection用
```
🎵 [COLLECTION_NAME] - [楽曲数] tracks, [時間]

[楽曲リスト with タイムスタンプ]

[bit数]-bit chiptune music inspired by classic RPG [テーマ]. 
Perfect for gaming, studying, or relaxing to nostalgic melodies.

📝 Usage & Attribution:
• This music is original AI composition
• Free to use with proper attribution to "8-Bit Adventure Hub"
• Please check your platform's AI content policies for commercial use

🎮 Individual tracks: [プレイリストURL]

#[bit数]BitMusic #ChiptuneStudy #RPGMusic #StudyBGM
```

#### Individual Track用（統一版・作業効率大幅向上）
```
[bit数]-bit chiptune music inspired by classic RPG adventures.
Perfect for gaming, studying, or relaxing.

📝 Usage & Attribution:
• This music is original AI composition
• Free to use with proper attribution to "8-Bit Adventure Hub"
• Please check your platform's AI content policies for commercial use

🎵 Full Collection: [Collection URL]
🎮 All tracks: [Playlist URL]

#[bit数]BitMusic #ChiptuneStudy #RPGMusic
```

#### Playlist用（v8.0実用版）
```
[bit数]-Bit [Collection Name] Music - Complete [テーマ] Playlist [絵文字][絵文字]

🎵 Welcome to 8-Bit Adventure Hub! 🎵

Experience the complete collection of [楽曲数] individual tracks from our [bit数]-Bit [Collection Name] [総時間]-hour masterpiece that will take you through every [テーマ] adventure! Each track is now available separately, perfect for finding your exact favorite [テーマ] moment or creating custom adventure playlists for any RPG mood! [絵文字]➡️[絵文字]

[絵文字] FROM THE [bit数]-Bit [Collection Name] Collection: This playlist features all [楽曲数] tracks from our complete [総時間]-hour [テーマ] masterpiece: ➤ Full: [Collection URL]

Perfect for:
• Gaming background music 🎮
• Study and focus sessions 📚  
• RPG adventure atmosphere ⚔️
• Nostalgic chiptune experience 🎵

#[bit数]BitMusic #[CollectionName]Playlist #RPGMusic #ChiptunePlaylist
```

### 2日間集中投稿システム
1. **Day 1**: Complete Collection（フル動画）投稿
2. **Day 2**: 全楽曲個別動画一斉投稿 + プレイリスト作成

## 📊 完成済みコレクション（22コレクション）

### 最新5コレクション
18. **16-Bit Royal Castle Collection** (24曲・1:27:11) - https://youtu.be/kmnUqTXyoUA
19. **8-Bit Field Battle Collection** (20曲・1:17:05) - https://youtu.be/bO0rz5FV1ss
20. **16-Bit Field Battle Collection** (20曲・1:14:56) - https://youtu.be/aF9oPCjm-Ds
21. **8-Bit Village & Town Collection ver.2** (20曲・1:18:48) - https://youtu.be/0pNqnPfedJM
22. **16-Bit Village & Town Collection ver.2** (20曲・1:03:24) - https://youtu.be/vBrUTjoGCwo

## 📝 重要ルール（v7.0統一版）

### 必須確認事項
- **claude.md確認必須**: タスク開始前の最新方針把握
- **ライトモチーフ統一必須**: v7.0コレクション一貫性戦略適用
- **誇張表現完全回避**: Epic/Ultimate等の使用禁止
- **awareness/記録必須**: 重要発見・変更の記録

### CTR最適化ルール
- **ヒューマンファクター重視**: 人物・顔要素でクリック誘発（場合により風景特化）
- **モバイル最適化**: 70%がモバイル視聴・文字32px以上
- **誇張表現回避**: 事実ベース表現・信頼性重視
- **ベンチマーク模倣**: 成功パターンの戦略的活用

### コミュニティ対応
- **高価値リスナー対応**: @agler4986等の建設的フィードバック重視
- **AI透明性維持**: "キュレーター・プロデューサー"として誠実対応
- **RPG固有名詞使用**: ゲームらしい楽曲タイトル採用

## 🎯 品質管理チェックリスト


### 音楽品質チェック（v8.0統合版）
```
□ テーマとの適合性
□ 8-bit/16-bit音源選択適切性（メイン8-bit、特別16-bit）
□ 8-bit音源の忠実再現（authentic Game Boy/NES sound）
□ 16-bit音源の活用（Orchestral Depth、Dynamic Range等）
□ 感情表現の深度（cheerful要素重視）
□ RPGシーンとの整合性
□ 楽曲タイトルとの一致性（RPG固有名詞使用）
□ 長時間聴取疲労回避（electronic guitar等排除）
□ 用途別最適長さ（ジングル ≠ 通常楽曲）
□ 装飾語マシマシ技法適用（感情深度最大化）
□ seamless loop structure確保
```

### サムネイル・タイトル品質チェック（誇張表現回避版）
```
□ タイトル誇張表現完全回避（Epic/Ultimate等禁止）
□ サムネイル文字モバイル最適化（32px以上）
□ Complete Collection専用サムネ作成
□ Individual Track動画内一枚絵使用
□ ブランド統一（[bit数]BIT BGM表記）
□ 事実ベース情報明記（曲数・時間）
□ 高コントラスト設定（7:1以上）
□ ヒューマンファクターOR風景特化選択適切
```

### 概要欄品質チェック（Over-promotional解決版）
```
□ 楽曲リスト（タイムスタンプ付き）配置
□ 簡潔な説明文（2-3行、宣伝感排除）
□ AI生成への透明性
□ シンプルハッシュタグ（4個以内）
□ 音楽体験を阻害しない情報提供
□ Over-promotional表現完全回避
□ クロスリンク適切配置（Collection↔Playlist）
```

## 📊 完成済みコレクション（22コレクション）

### 全コレクション一覧
1. **Adventure Music** (24曲・1:00:00) - https://youtu.be/j3VYctGmZTE
2. **Battle Music** (13曲・1:00:00) - https://youtu.be/BDgtysOgcmQ
3. **Dungeon Music** (16曲・1:00:00) - https://youtu.be/Imwkjvx-7bc
4. **Village & Town Music** (18曲・1:20:00) - https://youtu.be/V02uDsf7bZE
5. **Japanese RPG Music** (22曲・1:30:00) - https://youtu.be/aZKtTPszKPo
6. **Emotional Journey Music** (20曲・1:30:00) - https://youtu.be/g8uKX0sEugk
7. **Shop & Inn Music** (20曲・1:00:00+) - https://youtu.be/6xSV8IebioM
8. **Sleep & Dream Music** (26曲・1:30:00) - https://youtu.be/wPdfqSoXqjE
9. **RPG Class Music** (20曲・1:23:22) - https://youtu.be/YPMwKYVET1s
10. **Boss Rush Music** (18曲・1:14:22) - https://youtu.be/d2jCGRorxDM
11. **Adventure Season 2** (37曲・3:50:32) - https://youtu.be/VwBFfA5sr9s
12. **Guild & Quest Collection** (20曲・1:40:44) - https://youtu.be/nYCLeMcJL2k
13. **World Map Collection** (22曲・1:30:16) - https://youtu.be/6D_ph8hNwNY
14. **Treasure Collection** (22曲・1:46:21) - https://youtu.be/9fdLLfrtNp0
15. **Academy & Magic School Collection** (25曲・1:37:51) - https://youtu.be/5JSRFGxgE4c
16. **Nostalgia & Campfire Collection** (22曲・1:26:06) - https://youtu.be/514WfslqAkI
17. **16-Bit Adventure Collection** (24曲・1:46:18) - https://youtu.be/Nym-_wnCVbw
18. **16-Bit Royal Castle Collection** (24曲・1:27:11) - https://youtu.be/kmnUqTXyoUA
19. **8-Bit Field Battle Collection** (20曲・1:17:05) - https://youtu.be/bO0rz5FV1ss
20. **16-Bit Field Battle Collection** (20曲・1:14:56) - https://youtu.be/aF9oPCjm-Ds
21. **8-Bit Village & Town Collection ver.2** (20曲・1:18:48) - https://youtu.be/0pNqnPfedJM
22. **16-Bit Village & Town Collection ver.2** (20曲・1:03:24) - https://youtu.be/vBrUTjoGCwo


### 統計サマリー（2025-09-13現在）
- **総楽曲数**: 450+ 曲
- **総制作時間**: 30+ 時間  
- **平均楽曲数/コレクション**: 20.5曲
- **平均時間/コレクション**: 1:22:14
- **8-bit vs 16-bit比率**: 18:4（8-bit主体戦略）
- **ver.2改良版**: 2コレクション（Village & Town系）

## 📝 重要ルール（v8.0版）

### 必須確認事項
- **claude.md確認必須**: タスク開始前の最新方針把握
- **誇張表現完全回避**: Epic/Ultimate等の使用禁止
- **awareness/記録必須**: 重要発見・変更の記録
- **実ファイル確認必須**: 楽曲リスト・時間データ作成時

### CTR最適化ルール  
- **ヒューマンファクター重視**: 人物・顔要素でクリック誘発（場合により風景特化）
- **モバイル最適化**: 70%がモバイル視聴・文字32px以上
- **誇張表現回避**: 事実ベース表現・信頼性重視
- **ベンチマーク模倣**: 成功パターンの戦略的活用

### コミュニティ対応
- **高価値リスナー対応**: @agler4986等の建設的フィードバック重視
- **AI透明性維持**: "キュレーター・プロデューサー"として誠実対応
- **RPG固有名詞使用**: ゲームらしい楽曲タイトル採用

### 技術的ルール
- **FFmpegバックスラッシュ問題**: Bashでの `\\` → `\` 修正必須（エラー回避）
- **afinfo時間確認**: macOS最適化・正確測定必須
- **collections/ワークフロー**: planning → production → live移行管理

---

*更新日: 2025年9月13日*  
*バージョン: v8.0*  
*核心技術: FFmpeg完全自動化 + CTR誇張表現回避 + エージェントシステム統合*