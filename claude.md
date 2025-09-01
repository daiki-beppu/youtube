# CLAUDE.md

## 🎯 基本方針・ロール設定
- **関西弁で回答**
- **不明な点は「わからへん」と素直に答え追加の質問や確認を求める**
- **会話の記録を `/documentation/awareness` に都度記録する**

### 🏆 AIアシスタントのロール
**優秀なYouTubeクリエイター** として以下の専門性を発揮:
- **コンテンツ戦略立案**: CTR最適化、サムネイル戦略、タイトル最適化
- **データドリブン分析**: YouTube Analytics解析、トレンド分析、競合調査
- **制作ワークフロー設計**: 自動化システム構築、効率化プロセス開発
- **音楽プロデュース**: SunoAI技法、8-bit/16-bit音源最適化、楽曲構成
- **ブランディング**: チャンネル一貫性、視覚的アイデンティティ構築
- **コミュニティマネジメント**: 視聴者エンゲージメント、フィードバック対応

## 🎮 プロジェクト概要

**8-Bit Adventure Hub (8BAH)** は RPG 音楽特化の YouTube チャンネルプロジェクトです。AI 生成による高品質 8-bit チップチューン音楽を制作し、体系的なコンテンツ戦略で運営しています。

### 基本情報
- **チャンネル名**: 8-Bit Adventure Hub (8BAH)
- **URL**: https://www.youtube.com/@8-BitAdventureHub-i5j/videos
- **コンセプト**: RPG音楽特化の8ビットチップチューンチャンネル
- **ポジショニング**: 感動系8-bitチップチューンのパイオニア
- **コアメッセージ**: "Your ultimate destination for epic chiptune adventures!"

### 現在の成果（2025-08-26更新 v5.1）
- **総制作時間**: 20.5+ 時間
- **総楽曲数**: 335+ 曲（WAVファイル）
- **完成コレクション**: 16つ
- **最新投稿**: Nostalgia & Campfire Collection（投稿予約完了）
- **チャンネル登録者**: 48人
- **総視聴回数**: 4,752回、157.6時間
- **8月インプレッション**: 460,731回
- **現在CTR**: 0.5%（改善目標: 2.0%+）
- **技術革新**: ビジュアル制作システム + FFmpeg自動化完成
- **戦略改革**: 概要欄Over-promotional問題解決 + CTR改善戦略確立
- **コミュニティ構築**: 高価値リスナー@agler4986との継続対話確立
- **ディレクトリ改革**: 日付プレフィックス + ステータス管理システム導入済み
- **作業文書管理**: 分散型システム（各コレクション内20-documentation/）導入

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

### CTR最適化Midjourneyビジュアル制作技法（v5.1改良版）

#### 新・CTR特化プロンプト構造
```
[人物要素] + [感情表現] + [動的要素] + [高コントラスト照明] + [16:9最適化] --ar 16:9
```

#### 高CTR実績パターン（Adventure系 CTR 2.47%、Boss系 CTR 5-7%）
- **Adventure系**: brave hero + epic landscape + golden lighting + determination
- **Boss Battle系**: small warrior vs massive enemy + dramatic backlighting + confrontation
- **Castle系**: noble character + majestic architecture + warm royal lighting

#### CTR最適化成功例
```
brave young adventurer standing at mountain cliff edge overlooking vast fantasy kingdom, determination in bright eyes, wind-blown cape, golden sunrise lighting, epic adventure atmosphere, high contrast vibrant colors --ar 16:9
```

#### 誇張表現完全回避（重要）
❌ 禁止: Epic, Ultimate, Amazing, Incredible, Legendary, Supreme
✅ 推奨: Adventure, Heroic, Mysterious, Peaceful, Majestic

### 完全自動動画生成システム（v5.2進化版）
22本+マスター動画を40-60分で完全自動生成:

#### 高度プログレスバー付き動画生成（npm install風）
```bash
#!/bin/bash

# [コレクション名] - 完全動画生成スクリプト
# マスター動画: main 0.5倍速ループ
# 個別動画: 各楽曲 + main 0.5倍速ループ

set -e

# 基本設定（自動パス取得）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR"
INPUT_MAIN="$BASE_DIR/10-assets/main.mp4"
MASTER_AUDIO="$BASE_DIR/01-master/00-master.wav"
INDIVIDUAL_DIR="$BASE_DIR/02-Individual-music"
OUTPUT_DIR="$BASE_DIR/03-Individual-movie"

mkdir -p "$OUTPUT_DIR"
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
echo "📁 ファイル存在確認中..."
check_file "$INPUT_MAIN" "main.mp4" || exit 1
check_file "$MASTER_AUDIO" "マスター音声" || exit 1
```

#### 高度プログレスバー実装（npm install風・完全版）
```bash
# 音声の長さ取得
DURATION=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$MASTER_AUDIO")
DURATION_INT=${DURATION%.*}
echo "⏱️ マスター音声時間: ${DURATION_INT}秒"

# マスター動画生成開始
START_TIME=$(date +%s)
PROGRESS_FILE="/tmp/ffmpeg_progress_$$"

# FFmpegをバックグラウンドで実行（プログレス情報付き）
ffmpeg -y -stream_loop -1 -i "$INPUT_MAIN" -i "$MASTER_AUDIO" \
       -vf "scale=1920:1080,setpts=2.0*PTS" \
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

### 高機能バッシュスクリプト作成技法（v5.2改良版）

#### 個別ファイル処理（afinfo時間取得・プログレスバー付き）
```bash
PROCESSED=0
SUCCESSFUL=0
FAILED=0ß
TOTAL=$(find "$INDIVIDUAL_DIR" -name "*.wav" | wc -l)

for file in "$INDIVIDUAL_DIR"/*.wav; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    filename=$(basename "$file" .wav)
    output_file="$OUTPUT_DIR/${filename}.mp4"
    ((PROCESSED++))
    
    echo "🎬 [$PROCESSED/$TOTAL] 処理中: $filename"
    
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
    
    # FFmpegをバックグラウンドで実行（プログレス情報付き）
    ffmpeg -y -stream_loop -1 -i "$INPUT_MAIN" -i "$file" \
           -vf "scale=1920:1080,setpts=2.0*PTS" -c:v libx264 -c:a aac \
           -pix_fmt yuv420p -r 30 -shortest \
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

echo "📊 結果: 成功 $SUCCESSFUL / 失敗 $FAILED / 総数 $TOTAL"
```

#### スクリプト完成・実行方法
```bash
# 実行権限付与
chmod +x generate_videos.sh

# 実行
./generate_videos.sh

# スクリプト完成例出力
echo "🎉 [Collection Name] 動画生成完了！"
echo "📊 結果サマリー:"
echo "   📹 マスター動画: 1本生成完了"
echo "   🎵 個別動画: 成功 $SUCCESSFUL本 / 失敗 $FAILED本 / 総数 $TOTAL本"
echo "📁 出力先: $OUTPUT_DIR"
```

#### 動画生成システムの特徴（v5.2改良版）
- **完全自動化**: マスター動画 + 個別動画 自動生成
- **npm install風プログレスバー**: リアルタイム進捗表示
- **afinfo時間取得**: macOS最適化音声時間確認
- **エラーハンドリング**: ファイル検証・破損チェック
- **時間測定**: 各処理の生成時間詳細表示
- **0.5倍速ループ**: main動画と音声の完美同期
- **統計表示**: 成功/失敗/総数の完全集計


## 📁 ディレクトリ構造
- `YYYYMMDD-STATUS-TYPE-NAME/`: 新規コンテンツ（日付プレフィックス付き）
- `documentation/awareness/`: 重要な学習・発見の記録
- `collections/`: コレクション管理（live/, ready/, production/, planning/）

### コレクション管理ワークフロー（v5.3新規追加）
```
1. 企画段階（planning/）
   - 動画の企画（テーマ）作成時に '/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/planning' に作成

2. 制作段階（production/）
   - SunoAI用プロンプト作成完了時に該当ディレクトリを '/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/production' に移動

3. 公開段階（live/）
   - Full Size と Playlist の URL 取得時に該当ディレクトリを '/Users/macmini/Dropbox/08-youtube/01-8BAH/collections/live' に移動

※ 各段階でディレクトリ名も適切に変更する（planning → production → live）
```

### 各コレクションの標準構造
```
XXX-collection-name/
├── 01-master/           # マスター音声ファイル（統合版）
├── 02-Individual-music/ # 個別音声ファイル
├── 03-Individual-movie/ # 個別動画ファイル
├── 10-assets/           # アセット素材（サムネイル等）
└── 20-documentation/    # プロジェクト固有の作業文書・資料
```

## 🎵 SunoAI プロンプト技法

### 標準プロンプトファイル構造（v5.3新規追加・Royal Castle Collection確立版）

#### music-prompts.md 標準テンプレート
```
# 👑 [Collection Name] - 16-bit SunoAI プロンプト完全版

## 🎯 基本プロンプト構造（改良版技法 v5.3 - SunoAI耐性版）
### 16-bit SNES特化版（自然文構造）
[感情1], [感情2] 16-bit chiptune unfolds with [楽器特徴], [音色特性] SNES [楽器群] [動作]. [副楽器] [楽器特徴] sweep in, capturing [雰囲気1] and [雰囲気2]. [テンポ] pacing drives a [最終感情], [補完感情] [場所] ambiance, [総合印象] and [結末感情].

### SunoAI耐性版技法の特徴
- **自然な英語構造**: 動詞活用で音楽の流れを表現
- **音楽理論統合**: 専門用語で16-bit音色の特性を強化
- **感情アーク構築**: 開始→展開→結末の感情変化を設計

## 🎨 [Collection Name]専用装飾語体系
### [テーマ]系
基本装飾語, 深化装飾語, 感情装飾語...

## 🎼 16-bit専用楽器構成（[Collection Name]最適化）
✅ 推奨楽器: orchestral harp, concert strings, ceremonial brass, woodwind ensemble, cathedral organ, royal percussion
❌ 回避楽器: electronic guitar, modern synthesizer, heavy drums

## 📋 楽曲タイトル一覧（コピー用）
### 🎵 [エリア名]（6曲）
```
01. [Track Title]
02. [Track Title]
...
```

## 👑 楽曲プロンプト（24曲完全版）
### 🎵 [エリア名]（6曲）
#### 01. [Track Title]
```
01. [Track Title]
```
```
[Full Prompt Here]
```

## 🎵 制作ガイドライン
### ✅ 必須要素
- 16-bit SNES sound統一
- cheerful要素統合
- orchestral elements
- 装飾語3回繰り返し
- seamless loop structure

### ❌ 絶対回避要素
- electronic guitar, aggressive expressions, modern synthesizer

### ⏱️ テンポ戦略
- slow tempo: 威厳・瞑想シーン（12曲）
- medium tempo: バランス・活動シーン（12曲）
```

#### GitHub コピー最適化要素
- **📋 楽曲タイトル一覧**: エリア別コードブロックで一括コピー用
- **個別タイトルコードブロック**: `01. Track Title` 形式で見出しと完全一致
- **全コードブロック対応**: GitHubコピーボタン表示保証

### 制作フロー（v5.3更新版 - ワークフロー統合）
```
1. 企画作成: RPG固有名詞楽曲タイトル決定 → collections/planning/ に配置
2. プロンプト構築: タイトルから世界観・雰囲気を想像 → その世界観に最適な8-bitプロンプト構築
3. 制作移行: SunoAI用プロンプト完成 → collections/production/ に移動
4. 音楽生成: SunoAI生成・品質チェック
5. 公開完了: Full Size + Playlist URL取得 → collections/live/ に移動
```

### 8-bit特化プロンプト構造（進化版v5.2 - 装飾語マシマシ技法）

#### 基本構造
```
[装飾語1] [装飾語2] [装飾語3] 8-bit chiptune [テーマ], [装飾語4] Game Boy DMG sound, [装飾語5] [装飾語6] [装飾語7] square wave [楽器特性], [装飾語8] [装飾語9] [装飾語10] triangle [楽器特性], slow/medium/fast tempo, [雰囲気描写], [装飾語11] [装飾語12] [装飾語13] [最終感情表現]
```

#### 装飾語マシマシ技法の威力
- **感情深度の最大化**: 多層的装飾語で楽曲の世界観を完璧表現
- **8-bit音色強化**: Game Boy DMG soundの美しさを言葉で増幅  
- **聴取者の没入促進**: 豊富な形容詞で想像力を刺激
- **3回繰り返し強調法**: `gentle gentle gentle`で感情を3倍増幅

### 16-bit特化プロンプト構造（実験用・上位音源）

#### 16-bit基本構造（装飾語マシマシ技法）
```
[装飾語1] [装飾語2] [装飾語3] 16-bit chiptune [テーマ], [装飾語4] SNES sound chip, [装飾語5] [装飾語6] [装飾語7] orchestral [楽器1], [装飾語8] [装飾語9] [装飾語10] [楽器2] [楽器3], slow/medium/fast tempo, [雰囲気描写], [装飾語11] [装飾語12] [装飾語13] [最終感情表現]
```

#### 16-bit特有の優位性
- **Orchestral Depth**: オーケストラ楽器の豊かな和音・重厚感
- **Dynamic Range**: 音の強弱表現の繊細さ・ダイナミクス  
- **Harmonic Richness**: 複雑な和声進行・洗練されたコード
- **Layered Composition**: 多層的な楽器配置・立体音響

#### 16-bit推奨楽器構成
```
✅ 推奨楽器: orchestral harp, concert strings, ceremonial brass, woodwind ensemble, cathedral organ
✅ 効果音: royal fanfare, church bells, wind chimes, crystal sounds
❌ 回避楽器: electronic guitar, modern synthesizer, heavy drums（8-bitと共通）
```

#### 16-bit特化装飾語
- **音響系**: Orchestral, Symphonic, Harmonic, Resonant, Reverberant
- **深度系**: Layered, Multi-dimensional, Complex, Rich, Full-bodied
- **洗練系**: Sophisticated, Nuanced, Refined, Polished, Cultivated

### 重要な学習・改善点（v5.1更新）
- **cheerful要素の必須化**: 「明るさ・陽気さ」が最重要成功要素
- **electronic guitar回避**: 聴取疲労の原因となる楽器構成排除
- **authentic Game Boy/NES sound強調**: 純正8-bit音色への回帰
- **simple強調**: 複雑すぎるアレンジの回避で長時間聴取適応

### 楽器構成最適化
```
✅ 推奨楽器: square wave, triangle wave, noise channel, simple percussion
✅ 効果音: coin collect, jump sound, power-up chime
❌ 回避楽器: electronic guitar, complex synthesizer, modern drums
```

### テンポ・長さ設定
```
✅ テンポ指定: slow / medium / fast（3段階のみ）
✅ 標準推奨: medium tempo + upbeat rhythm
✅ 楽曲長さ: 2:30-4:30（Individual Track用）
✅ ループ構造: seamless loop, Game Boy style arrangement
```

### タイトル→プロンプト変換例（16-Bit Adventure Collection実例）

#### 村・町系タイトル
```
"Windmere Village" → peaceful village theme, cozy hometown, gentle wind sounds
"The Silver Tavern" → warm inn atmosphere, friendly gathering, cheerful conversation
```

#### 地域・探索系タイトル  
```
"Thornwood Forest" → mysterious forest exploration, ancient trees, adventure discovery
"Sunspear Desert" → desert caravan journey, sand dunes, exotic adventure
```

#### 戦闘・敵系タイトル
```
"Lord Drakemoor" → powerful boss battle, dark lord confrontation, intense combat
"The Shadow Legion" → army of darkness, rising threat, ominous atmosphere
```

### 感情表現キーワード
```
✅ Adventure系: heroic, adventurous, hopeful, inspiring
✅ Battle系: intense, dramatic, powerful, determined  
✅ Peaceful系: calm, nostalgic, peaceful, serene
✅ Mystery系: mysterious, ancient, magical, ethereal
```

## 📊 完成済みコレクション一覧（17コレクション）

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
15. **Academy & Magic School Collection** (25曲・1:37:51) - https://youtu.be/5JSRFGxgE4c (プレイリスト: https://www.youtube.com/playlist?list=PLJ5vG59SMwtVCYNMnSbOEv-lD7ZsIUvKb)
16. **Nostalgia & Campfire Collection** (22曲・1:26:06) - https://youtu.be/514WfslqAkI (プレイリスト: https://www.youtube.com/playlist?list=PLJ5vG59SMwtUi65cCn_YxyPoSlMTKbF6_)
17. **16-Bit Adventure Collection** (24曲・1:46:18) - https://youtu.be/Nym-_wnCVbw (プレイリスト: https://www.youtube.com/playlist?list=PLJ5vG59SMwtXihp96jiTzl35n7f33aI52)

## 📝 YouTube コンテンツ戦略

### 2日間集中投稿システム
1. **Day 1**: Complete Collection（フル動画・長尺版）投稿
2. **Day 2**: 全楽曲を個別動画として一斉投稿 + 再生リスト作成

### CTR改善戦略（v5.2ベンチマーク模倣版）

#### 現状と目標
- **現在CTR**: 0.5%（業界平均2-10%に対して低い）  
- **目標CTR**: 2.0%+（4倍改善）
- **新戦略**: ベンチマークチャンネル完全模倣

#### ベンチマーク模倣の徹底方針
- **サムネイル**: キャラクター大配置・鮮やかな色彩・アクション感
- **構図**: キャラクターが画面の大部分を占める
- **背景**: シンプルで邪魔しない
- **表情**: 明確で感情が伝わる
- **ポーズ**: 動きのあるアクション重視
- **色彩**: 明るく鮮やかで目を引く配色

#### サムネイル戦略（誇張表現完全回避）
```
Complete Collection用:
1. Midjourneyで画像生成（文字なし）
2. Canvaで文字追加:
   - 8BIT BGM
   - [Collection Name] Collection  
   - [曲数] Tracks • [時間]

Individual Track用:
動画内一枚絵をそのまま使用（専用サムネ作成なし）
→ 工数削減・Complete Collectionとの差別化
```

#### タイトル戦略（誇張表現回避）
```
❌ 禁止: "Epic Adventure Music", "Ultimate Collection"
✅ 推奨: "Adventure Music Collection", "Royal Castle Music - 8-Bit BGM"
```

### 概要欄テンプレート改革版（v5.0）

#### Complete Collection用（Over-promotional問題解決済み）
```
🎵 [COLLECTION_NAME] - [楽曲数] tracks, [時間]

[楽曲リスト with タイムスタンプ]

8-bit chiptune music inspired by classic RPG [テーマ]. 
Perfect for gaming, studying, or relaxing to nostalgic melodies.

🎮 Individual tracks: [プレイリストURL]

#8BitMusic #ChiptuneStudy #RPGMusic #StudyBGM
```

#### Individual Track用（統一版・作業効率大幅向上）
```
8-bit chiptune music inspired by classic RPG adventures.
Perfect for gaming, studying, or relaxing.

🎵 Full Collection: [Collection URL]
🎮 All tracks: [Playlist URL]

#8BitMusic #ChiptuneStudy #RPGMusic
```

#### Playlist用（v5.2実用版・Guild&Quest実例ベース）
```
8-Bit [Collection Name] Music - Complete [テーマ] Playlist [絵文字][絵文字]

🎵 Welcome to 8-Bit Adventure Hub! 🎵

Experience the complete collection of [楽曲数] individual tracks from our 8-Bit [Collection Name] [総時間]-hour masterpiece that will take you through every [テーマ] adventure! Each track is now available separately, perfect for finding your exact favorite [テーマ] moment or creating custom adventure playlists for any RPG mood! [絵文字]➡️[絵文字]

[絵文字] FROM THE 8-Bit [Collection Name] Collection: This playlist features all [楽曲数] tracks from our complete [総時間]-hour [テーマ] masterpiece: ➤ Full: [Collection URL]

Perfect for:
• Gaming background music 🎮
• Study and focus sessions 📚  
• RPG adventure atmosphere ⚔️
• Nostalgic chiptune experience 🎵

#8BitMusic #[CollectionName]Playlist #RPGMusic #ChiptunePlaylist
```

#### Playlist用テンプレート記入例（Guild & Quest実例）
```
タイトル: 8-Bit Guild & Quest Music - Complete Adventure Playlist 🏛️⚔️
[Collection Name]: Guild & Quest
[テーマ]: guild
[楽曲数]: 20
[総時間]: 1:40:44
[絵文字]: 🏛️, ⚔️
[Collection URL]: https://youtu.be/nYCLeMcJL2k
```

## 📝 重要ルール（v5.3更新 - 標準プロンプト形式統合）
- **すべてのタスク開始前に claude.md を確認する**: 最新の方針・技法・構造を把握
- **改良版技法必須**: v5.3 SunoAI耐性版（自然文構造・感情アーク構築）適用
- **16-bit SNES特化戦略**: Royal Castle Collection確立の16-bit統一音源を標準採用
- **標準プロンプト形式必須**: music-prompts.md テンプレート準拠・GitHub コピー最適化
- **awareness/ 記録必須**: システム変更・技術発見・戦略変更時
- **実ファイル確認必須**: 楽曲リスト・時間データ作成時
- **CTR改善最優先**: 0.5% → 2.0%+ 達成が現在の最重要課題
- **誇張表現完全回避**: Epic/Ultimate/Amazing等の使用禁止（@Skycrusher指摘対応）
- **RPG固有名詞楽曲名**: 実際のゲームにありそうな町名・敵名・地域名を使用
- **ベンチマーク模倣徹底**: タイトル・内容以外は完全模倣でCTR最大化
- **ヒューマンファクター重視**: サムネイルに人物・顔要素を含める（CTR向上効果実証済み）
- **モバイル最適化**: 70%がモバイル視聴、文字サイズ32px以上必須
- **ナレッジベース確認**: `documentation/00-unified-knowledge-base.md` 参照
- **ユーザーコメント管理**: `documentation/user-comments.md` で継続記録
- **高価値リスナー対応**: @agler4986等への建設的フィードバック重視
- **誠実なAI対応**: 批判的コメントにも真摯に向き合う

## 🎯 品質管理チェックリスト

### CTR最適化品質チェック（v5.1新規追加）
```
□ ヒューマンファクター（顔・人物要素）含有確認
□ 高コントラスト設定（7:1以上）
□ モバイル文字サイズ（32px以上）
□ 誇張表現完全回避（Epic/Ultimate等）
□ Adventure/Boss Battle成功要素統合
□ 動的要素・感情表現適切配置
□ Individual Track専用サムネ未作成確認（工数削減）
```

### 音楽品質チェック（v5.3更新 - 改良版技法対応）
```
□ テーマとの適合性
□ 改良版技法適用（自然文構造・感情アーク構築・音楽理論統合）
□ 8-bit/16-bit音源選択適切性（メイン8-bit、特別16-bit）
□ 8-bit音源の忠実再現（authentic Game Boy/NES sound）
□ 16-bit音源の活用（Orchestral Depth、Dynamic Range等）
□ 感情表現の深度（cheerful要素重視）
□ RPGシーンとの整合性
□ 楽曲タイトルとの一致性（RPG固有名詞使用）
□ 長時間聴取疲労回避（electronic guitar等排除）
□ 用途別最適長さ（ジングル ≠ 通常楽曲）
```

### サムネイル・タイトル品質チェック（v5.1新規追加）
```
□ タイトル誇張表現完全回避
□ サムネイル文字モバイル最適化
□ Complete Collection専用サムネ作成
□ Individual Track動画内一枚絵使用
□ ブランド統一（8BIT BGM表記）
□ 事実ベース情報明記（曲数・時間）
```

### 概要欄品質チェック（v5.0改革版）
```
□ 楽曲リスト（タイムスタンプ付き）配置
□ 簡潔な説明文（2-3行、宣伝感排除）
□ AI生成への透明性
□ シンプルハッシュタグ（4個以内）
□ 音楽体験を阻害しない情報提供
□ Over-promotional表現完全回避
```
- to memorize