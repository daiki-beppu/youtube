# CLAUDE.md

## 🎯 基本方針
- **関西弁で回答**
- **不明な点は「わからへん」と素直に答え追加の質問や確認を求める**
- **会話の記録を `/documentation/awareness` に都度記録する**

## 🎮 プロジェクト概要

**8-Bit Adventure Hub (8BAH)** は RPG 音楽特化の YouTube チャンネルプロジェクトです。AI 生成による高品質 8-bit チップチューン音楽を制作し、体系的なコンテンツ戦略で運営しています。

### 基本情報
- **チャンネル名**: 8-Bit Adventure Hub (8BAH)
- **URL**: https://www.youtube.com/@8-BitAdventureHub-i5j/videos
- **コンセプト**: RPG音楽特化の8ビットチップチューンチャンネル
- **ポジショニング**: 感動系8-bitチップチューンのパイオニア
- **コアメッセージ**: "Your ultimate destination for epic chiptune adventures!"

### 現在の成果（2025-08-23更新）
- **総制作時間**: 19.1+ 時間
- **総楽曲数**: 313曲（WAVファイル）
- **完成コレクション**: 14つ
- **制作中**: Academy & Magic School Collection（企画中）
- **ディレクトリ改革**: 日付プレフィックス + ステータス管理システム導入済み
- **作業文書管理**: 分散型システム（各コレクション内20-documentation/）導入
- **プロンプト技法確立**: 装飾語マシマシ + 繰り返し強調 + ループ最適化

## 🔧 重要なワークフロー

### 音声ファイル時間確認
```bash
# macOS の afinfo を使用
afinfo "ファイル名.wav"

# 複数ファイルの一括確認
for file in *.wav; do echo "=== $file ==="; afinfo "$file" | grep "estimated duration"; done
```

### タイムスタンプ計算
```python
def format_timestamp(seconds):
    hours = int(seconds // 3600)
    minutes = int((seconds % 3600) // 60)
    seconds = int(seconds % 60)
    
    if hours > 0:
        return f"{hours}:{minutes:02d}:{seconds:02d}"
    else:
        return f"{minutes}:{seconds:02d}"
```

### FFmpeg 動画ファイル作成
音声ファイル + 静止画サムネイルから YouTube 用動画を自動生成:
```bash
ffmpeg -loop 1 -i "[サムネイル.png]" -i "[音声.wav]" -c:v libx264 -c:a aac -shortest "[出力.mp4]"
```

動画ファイル + 音声ファイルから 0.5倍速ループ動画生成:
```bash
ffmpeg -y -stream_loop -1 -i "[動画.mp4]" -i "[音声.wav]" -vf "scale=1920:1080,setpts=2.0*PTS" -c:v libx264 -c:a aac -pix_fmt yuv420p -r 30 -shortest "[出力.mp4]"
```

### 高機能バッシュスクリプト（.sh）作成方法

#### 基本構造（自動パス取得 + エラーハンドリング）
```bash
#!/bin/bash

# スクリプトの説明コメント
set -e

# 基本設定（スクリプトの場所から自動取得）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR"
INPUT_VIDEO="$BASE_DIR/10-assets/main-movie.mp4"
INPUT_AUDIO="$BASE_DIR/01-master/master-audio.wav"
OUTPUT_DIR="$BASE_DIR/03-Individual-movie"

# ディレクトリ作成
mkdir -p "$OUTPUT_DIR"

echo "🎬 処理開始"
echo "📁 作業ディレクトリ: $BASE_DIR"
```

#### 高度なファイル確認・バリデーション
```bash
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

# 音声ファイル確認
echo "🎵 音声ファイル確認中..."
if [ ! -f "$INPUT_AUDIO" ]; then
    echo "❌ エラー: 音声ファイルが見つかりません"
    echo "   パス: $INPUT_AUDIO"
    exit 1
fi

if ! ffprobe -v quiet -show_format "$INPUT_AUDIO" > /dev/null 2>&1; then
    echo "❌ エラー: 音声ファイルが破損しているか、サポートされていない形式です"
    exit 1
fi
echo "✅ 音声ファイル: $(basename "$INPUT_AUDIO") - 有効"
```

#### npm install風プログレスバー付き処理
```bash
# 時間測定開始
START_TIME=$(date +%s)

# プログレス情報を一時ファイルに出力
PROGRESS_FILE="/tmp/ffmpeg_progress_$$"

# FFmpegをバックグラウンドで実行
ffmpeg -y -i "$INPUT_VIDEO" -i "$INPUT_AUDIO" \
       -c:v libx264 -c:a aac \
       -progress "pipe:1" \
       "$OUTPUT_FILE" 2>/dev/null | grep "out_time_ms" > "$PROGRESS_FILE" &

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
            TARGET_MS=$((DURATION * 1000))
            if [ "$TARGET_MS" -gt 0 ]; then
                PROGRESS=$((CURRENT_MS * 100 / TARGET_MS))
                if [ "$PROGRESS" -gt 100 ]; then
                    PROGRESS=100
                fi
                
                # プログレスバーを構築
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
                
                printf "\r     %s [%s] %d%%" "$SPINNER" "$BAR" "$PROGRESS"
                LAST_PROGRESS=$PROGRESS
            fi
        fi
    fi
    
    # プログレス未取得時はスピナーのみ
    if [ "$LAST_PROGRESS" -eq -1 ]; then
        SPINNER=${SPINNER_CHARS[$SPINNER_INDEX]}
        SPINNER_INDEX=$(( (SPINNER_INDEX + 1) % 10 ))
        printf "\r     %s 処理中..." "$SPINNER"
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

# 一時ファイル削除
rm -f "$PROGRESS_FILE"
```

#### 個別ファイル処理（時間測定付き）
```bash
PROCESSED=0
SUCCESSFUL=0
FAILED=0

for file in "$INPUT_DIR"/*.wav; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    filename=$(basename "$file" .wav)
    ((PROCESSED++))
    echo "🎬 [$PROCESSED/$TOTAL] 処理中: $filename"
    
    # 個別処理時間測定
    INDIVIDUAL_START=$(date +%s)
    
    # 処理実行（プログレスバー付き）
    if process_file_with_progress "$file"; then
        INDIVIDUAL_END=$(date +%s)
        INDIVIDUAL_ELAPSED=$((INDIVIDUAL_END - INDIVIDUAL_START))
        echo "   ✅ 完了 (生成時間: ${INDIVIDUAL_ELAPSED}秒)"
        ((SUCCESSFUL++))
    else
        echo "   ❌ エラー"
        ((FAILED++))
    fi
    
    echo ""
done

echo "📊 結果: 成功 $SUCCESSFUL / 失敗 $FAILED / 総数 $PROCESSED"
```

#### 実行方法
```bash
# 実行権限付与
chmod +x script.sh

# 実行
./script.sh

# または
bash script.sh
```

## 📁 ディレクトリ構造
- `YYYYMMDD-STATUS-TYPE-NAME/`: 新規コンテンツ（日付プレフィックス付き）
- `documentation/awareness/`: 重要な学習・発見の記録
- `collections/`: コレクション管理（live/, ready/, production/, planning/）

### 各コレクションの標準構造
```
XXX-collection-name/
├── 01-master/           # マスター音声ファイル（統合版）
├── 02-Individual-music/ # 個別音声ファイル
├── 03-Individual-movie/ # 個別動画ファイル
├── 10-assets/           # アセット素材（サムネイル等）
└── 20-documentation/    # プロジェクト固有の作業文書・資料
```

## 🎵 プロンプト技法

### 8-bit特化プロンプト構造
```
authentic Game Boy DMG sound loop music [テーマ] + [楽器 楽器 楽器] + [テンポ テンポ テンポ] + [雰囲気 雰囲気 雰囲気]
```

## 📊 完成済みコレクション一覧（14コレクション）

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

## 📝 YouTube コンテンツ戦略

### 2日間集中投稿システム
1. **Day 1**: Complete Collection（フル動画・長尺版）投稿
2. **Day 2**: 全楽曲を個別動画として一斉投稿 + 再生リスト作成

### 概要欄テンプレート（Complete Collection用）
```
🎵 [COLLECTION_NAME] - [楽曲数] tracks, [時間]

[楽曲リスト with タイムスタンプ]

8-bit chiptune music inspired by classic RPG [テーマ]. 
Perfect for gaming, studying, or relaxing to nostalgic melodies.

🎮 Individual tracks: [プレイリストURL]

#8BitMusic #ChiptuneStudy #RPGMusic #StudyBGM
```

## 📝 重要ルール
- **すべてのタスク開始前に claude.md を確認する**: 最新の方針・技法・構造を把握
- **awareness/ 記録必須**: システム変更・技術発見・戦略変更時
- **実ファイル確認必須**: 楽曲リスト・時間データ作成時
- **ナレッジベース確認**: `documentation/00-unified-knowledge-base.md` 参照

## 🎯 品質管理チェックリスト

### 音楽品質チェック
```
□ テーマとの適合性
□ 8-bit音源の忠実再現
□ 感情表現の深度
□ RPGシーンとの整合性
□ 楽曲タイトルとの一致性
```

### 概要欄品質チェック
```
□ 楽曲リスト（タイムスタンプ付き）配置
□ 簡潔な説明文（2-3行）
□ AI生成明記
□ シンプルハッシュタグ（4個以内）
□ 関連コレクション1-2個のみ
```