# 🎮 8-Bit Adventure Hub (8BAH)

**8-Bit Adventure Hub** は、RPG音楽に特化したチップチューンチャンネルプロジェクトやで。AI生成による高品質な8-bit/16-bit音楽を制作して、YouTubeで配信しとるんや。

## 📌 基本情報

- **チャンネル名**: 8-Bit Adventure Hub (8BAH)
- **URL**: https://www.youtube.com/@8-BitAdventureHub-i5j/videos
- **コンセプト**: RPG音楽特化のチップチューンチャンネル
- **総楽曲数**: 450+ 曲
- **完成コレクション**: 22+ コレクション

## 🛠️ 必要なツール・環境

### システム要件
- **macOS** (推奨) - afinfoコマンドが必要
- **Bash** 対応シェル

### 必要なソフトウェア
- **FFmpeg** - 動画生成に必須
  ```bash
  # Homebrewでインストール
  brew install ffmpeg
  ```
- **afinfo** - macOS標準搭載の音声情報取得ツール

### オプション
- **SunoAI** アカウント - 音楽生成用
- **Midjourney** アカウント - サムネイル画像生成用

## 📁 プロジェクト構造

```
01-8BAH/
├── CLAUDE.md                     # プロジェクト設定・ガイドライン
├── README.md                     # このファイル
├── collections/                  # コレクション管理システム
│   ├── planning/                # 企画中コレクション
│   ├── production/              # 制作中コレクション
│   └── live/                    # 公開済みコレクション
├── documentation/               # プロジェクト文書
│   ├── 00-unified-knowledge-base.md
│   └── awareness/               # 学習・改善記録
├── resources/                   # リソース・テンプレート
│   ├── assets/                  # 共通素材
│   └── templates/               # テンプレートファイル
└── analytics/                   # 分析データ
```

### コレクション標準構造
```
XXX-collection-name/
├── 01-master/                   # マスター音声・動画
│   ├── 00-master.wav           # マスター音声ファイル
│   └── Collection-Master.mp4   # マスター動画
├── 02-Individual-music/         # 個別音声ファイル
├── 03-Individual-movie/         # 個別動画ファイル
├── 10-assets/                   # 静止画素材
│   └── main.png                # メイン画像
├── 20-documentation/            # 作業文書
└── generate_videos.sh           # 動画生成スクリプト
```

## 🚀 使い方

### 1. 新しいコレクションの作成

1. **企画段階**: `collections/planning/` にディレクトリ作成
2. **制作段階**: `collections/production/` に移動
3. **公開段階**: `collections/live/` に移動

### 2. 動画生成

各コレクションフォルダに含まれる `generate_videos.sh` を実行するんや：

```bash
# コレクションディレクトリに移動
cd collections/live/YOUR-COLLECTION-NAME/

# スクリプトに実行権限付与
chmod +x generate_videos.sh

# 動画生成実行
./generate_videos.sh
```

#### 動画生成の流れ
1. **ファイル確認**: 必要なファイル（音声・画像）の存在チェック
2. **マスター動画生成**: 01-master/ フォルダに保存
3. **個別動画生成**: 02-Individual-music/ の全楽曲を動画化
4. **進捗表示**: npm install風のプログレスバー表示
5. **結果レポート**: 成功/失敗数の統計表示

### 3. 必要ファイルの準備

動画生成前に以下のファイルを準備してな：

```bash
# 必須ファイル
01-master/00-master.wav          # マスター音声
10-assets/main.png              # メイン画像（16:9推奨）
02-Individual-music/*.wav       # 個別楽曲ファイル
```

## 📊 主な機能

### 自動動画生成システム v7.0
- **完全自動化**: マスター + 個別動画を一括生成
- **静止画対応**: PNG画像から動画を自動生成
- **進捗表示**: リアルタイムプログレスバー
- **エラーハンドリング**: ファイル検証・破損チェック
- **統計機能**: 処理時間・成功率の詳細レポート

### コレクション管理
- **ワークフロー**: planning → production → live
- **標準化**: 統一されたディレクトリ構造
- **文書化**: 各段階での記録・テンプレート完備

## 🎵 音楽制作技法

### ライトモチーフ統一戦略 v7.0
```
[テーマ感情], [装飾語] 8/16-bit chiptune unfolds with [共通音響基盤], 
[音色特性] [楽器群]. [統一副楽器] sweep in, capturing [テーマ特徴] and 
[共通展開感情]. [テンポ] pacing drives a [共通展開], [装飾語] and [共通結末感情].
```

### 推奨楽器構成
- **8-bit**: square wave, triangle wave, noise channel
- **16-bit**: orchestral harp, concert strings, ceremonial brass
- **回避**: electronic guitar, modern synthesizer, heavy drums

## 📋 よくある質問

### Q: 動画生成が失敗するんやけど？
A: 以下を確認してな：
1. FFmpegがインストールされてるか
2. 必要ファイル（00-master.wav, main.png）が存在するか
3. 音声ファイルが破損してないか

### Q: 音声時間が取得できへん
A: macOSの場合は `afinfo` コマンドを使用してるから、他のOSでは適宜変更が必要やで

### Q: 生成された動画のサイズがおかしい
A: main.pngは16:9のアスペクト比で作成することを推奨しとるで

## 📈 実績

- **総制作時間**: 30+ 時間
- **チャンネル登録者**: 60+ 人
- **CTR**: 0.59% → 2.0%+ 改善目標
- **最新投稿**: 16-Bit Village & Town Collection ver.2

## 🔗 関連リンク

- [YouTube チャンネル](https://www.youtube.com/@8-BitAdventureHub-i5j/videos)
- [プロジェクトガイドライン](./CLAUDE.md)
- [統合ナレッジベース](./documentation/00-unified-knowledge-base.md)

---

**🎮 Your ultimate destination for epic chiptune adventures! 🎵**