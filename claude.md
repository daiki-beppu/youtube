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

### バッシュスクリプト（.sh）作成方法

#### 基本構造
```bash
#!/bin/bash

# スクリプトの説明コメント
# エラー時に停止
set -e

# 変数定義
BASE_DIR="/path/to/project"
INPUT_FILE="$BASE_DIR/input.wav"
OUTPUT_DIR="$BASE_DIR/output"

# 処理実行
echo "🎬 処理開始"
# ここに実際のコマンドを記述

echo "✅ 処理完了"
```

#### ファイル確認・バリデーション
```bash
# ファイル存在確認
if [ ! -f "$INPUT_FILE" ]; then
    echo "❌ エラー: ファイルが見つかりません"
    echo "   パス: $INPUT_FILE"
    exit 1
fi

# ffprobeでファイル有効性確認
if ! ffprobe -v quiet -show_format "$INPUT_FILE" > /dev/null 2>&1; then
    echo "❌ エラー: ファイルが破損しているか、サポートされていない形式です"
    exit 1
fi
echo "✅ ファイル: $(basename "$INPUT_FILE") - 有効"
```

#### ループ処理・進行表示
```bash
PROCESSED=0
SUCCESSFUL=0
FAILED=0

for file in "$INPUT_DIR"/*.wav; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    ((PROCESSED++))
    echo "🎬 [$PROCESSED/$TOTAL] 処理中: $(basename "$file")"
    
    if some_command "$file"; then
        ((SUCCESSFUL++))
        echo "   ✅ 完了"
    else
        ((FAILED++))
        echo "   ❌ エラー"
    fi
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