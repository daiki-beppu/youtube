# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 🎮 プロジェクト概要

**8-Bit Adventure Hub (8BAH)** は RPG 音楽特化の YouTube チャンネルプロジェクトです。AI 生成による高品質 8-bit チップチューン音楽を制作し、体系的なコンテンツ戦略で運営しています。

### 基本情報
- **チャンネル名**: 8-Bit Adventure Hub (8BAH)
- **URL**: https://www.youtube.com/@8-BitAdventureHub-i5j/videos
- **コンセプト**: RPG音楽特化の8ビットチップチューンチャンネル
- **ポジショニング**: 感動系8-bitチップチューンのパイオニア
- **コアメッセージ**: "Your ultimate destination for epic chiptune adventures!"

### 現在の成果（2025-08-17更新）
- **総制作時間**: 19.1+ 時間
- **総楽曲数**: 313曲（WAVファイル）
- **完成コレクション**: 13つ
- **最新投稿**: World Map Collection（22楽曲・1:30:16）
- **ディレクトリ改革**: 日付プレフィックス + ステータス管理システム導入済み
- **作業文書管理**: 分散型システム（各コレクション内20-documentation/）導入
- **プロンプト技法進化**: ループ最適化 + AI サムネイル戦略確立

### ブランド価値
1. **技術革新**: プロンプトエンジニアリングのパイオニア
2. **感情体験**: 単なるBGMを超えた感動体験の提供
3. **成長物語**: novice adventurer → legendary hero の共感
4. **完全性**: あらゆるRPGシーンに対応する包括性

## 重要なワークフロー

### 音声ファイル時間確認
```bash
# macOS の afinfo を使用
afinfo "ファイル名.wav"

# 複数ファイルの一括確認
for file in *.wav; do echo "=== $file ==="; afinfo "$file" | grep "estimated duration"; done
```

### タイムスタンプ計算
Python を使用してタイムスタンプを計算:
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

### FFmpeg 動画ファイル作成（2025-08-17 確立）
音声ファイル + 静止画サムネイルから YouTube 用動画を自動生成:

#### 基本コマンド
```bash
ffmpeg -loop 1 -i "[サムネイル.png]" -i "[音声.wav]" -c:v libx264 -c:a aac -shortest "[出力.mp4]"
```

#### バッチ処理例
```bash
#!/bin/bash
# 複数ファイル一括変換
for i in {1..22}; do
    ffmpeg -y -loop 1 \
      -i "thumbnail.png" \
      -i "${i}-track.wav" \
      -c:v libx264 -c:a aac -shortest \
      "${i}-track.mp4"
done
```

#### 品質基準
- 解像度: 1280x720 (HD)
- コーデック: H.264/AAC
- 処理速度: 約10-11x リアルタイム
- YouTube最適化済み

## アーキテクチャ

### ディレクトリ構造
- `000-xxx/`: 過去の音楽コレクション（001-adventure, 002-battle など）
- `YYYYMMDD-STATUS-TYPE-NAME/`: 新規コンテンツ（日付プレフィックス付き）
- `documentation/`: プロジェクト戦略・ノウハウ・記録の統合管理
  - `knowledges/`: 体系化された知識ベース
  - `awareness/`: プロジェクト進行中の気づき・学びの記録
  - **廃止予定**: `working/` → 各コレクション内の `20-documentation/` に移行
- `collections/`: コレクション管理（live/, ready/, production/, planning/, archives/）
- **削除済み**: `individuals/` ディレクトリ（2日間投稿システムに移行）
- `operations/`: 運営業務（analytics/, seo-content/, thumbnails/, scheduling/）
- `resources/`: 共通リソース（templates/, assets/）

### 各コレクションの標準構造
```
XXX-collection-name/
├── 01-master/           # マスター音声ファイル（統合版）
│   ├── 00-master.wav   # 全楽曲統合音声
│   └── 00-master.mp4   # 全楽曲統合動画
├── 02-Individual-music/ # 個別音声ファイル
├── 03-Individual-movie/ # 個別動画ファイル
├── 10-thumbnail/        # サムネイル素材
└── 20-documentation/    # プロジェクト固有の作業文書・資料
```

### 📋 新しい作業文書管理システム

#### 🎯 運用方針変更
- **旧システム**: 全体の `documentation/working/` で一元管理
- **新システム**: 各コレクション内の `20-documentation/` で個別管理

#### 📁 20-documentation/ の用途
- プロジェクト固有の企画書・設計書
- サムネイル用プロンプト・素材
- 概要欄ドラフト・テンプレート
- 制作進捗・メモ・アイデア
- プロンプトエンジニアリング実験記録

#### 🔄 ライフサイクル
1. **制作中**: `20-documentation/` で作業文書管理
2. **完成後**: 必要に応じて `documentation/awareness/` に学習記録移動
3. **アーカイブ**: コレクション完了後も固有資料として保持

#### ✅ メリット
- **自己完結型**: コレクション関連資料の一元管理
- **作業効率**: プロジェクト切り替え時の文脈維持
- **構造シンプル化**: グローバル working ディレクトリ不要
- **スケーラビリティ**: 新規コレクション作成時の標準化

## マスターナレッジベースシステム

### 必須確認事項
1. **回答前に必ずマスターナレッジベース確認**: `documentation/00-unified-knowledge-base.md` を参照
2. **ファイル構成の実態確認**: 楽曲リスト・時間データ作成時は必ず実ファイルを確認
3. **時間表記統一**: 1時間未満 `xx:xx` / 1時間以上 `x:xx:xx` 形式厳守

### ナレッジファイル構成
- `documentation/00-unified-knowledge-base.md`: 統合知識ベース（必ず最初に参照）
- 全ての旧ナレッジファイルが統合済み
- 新しい学びは `documentation/awareness/` で記録
- **廃止済み**: `documentation/working/` → 各コレクション内 `20-documentation/` に移行

### 📝 学習記録ルール
**🚨 最重要**: ユーザーとのやりとりのたびに、重要な学習・発見・変更は必ず `documentation/awareness/` にファイルを作成して記録する

#### 📋 毎回チェック項目
**各セッション終了時に以下を確認し、該当する場合は必ずawareness/ファイル作成**：

##### 必須記録対象
- **システム・ワークフロー変更**: ディレクトリ構造、運用方針、作業手順の変更
- **技術的発見・改善**: プロンプト技法、制作手法、ツール活用の新発見
- **戦略・方針変更**: 投稿システム、SEO戦略、ブランディング方針の更新
- **重要な問題解決**: 困難な課題の解決方法、回避すべき問題の記録
- **外部要因変更**: プラットフォーム仕様変更、市場環境変化への対応

##### 追加記録推奨対象
- **新規コレクション企画**: テーマ選定・戦略決定・プロンプト開発
- **アナリティクス分析**: パフォーマンス変化・視聴者行動の新発見
- **競合調査**: 他チャンネル分析・市場変化・差別化戦略
- **ユーザーフィードバック**: コメント・評価・視聴者要望の重要パターン
- **制作効率化**: 作業時間短縮・品質向上・ミス回避の新手法

#### ファイル命名規則
```
YYYYMMDD-タイトル.md
例: 20250816-documentation-management-system-evolution.md
```

#### 記録フォーマット
- **変更概要**: 何が変わったか
- **背景・理由**: なぜ変更したか  
- **具体的内容**: どのように変更したか
- **期待効果**: 何が改善されるか
- **学習・気づき**: 今後に活かせる知見

#### 🔄 実行手順（Claude用）
**ユーザーからの呼び出しのたびに以下を復唱・実行**：

1. **セッション開始時**：「今回のやりとりで重要な学習・発見があれば、awareness/ディレクトリに記録します」と宣言
2. **作業中**：重要な発見・変更・問題解決があった際は即座にメモ
3. **セッション終了前**：記録すべき内容がある場合は awareness/ ファイル作成を提案・実行
4. **記録完了後**：「本日の重要な学習を awareness/[ファイル名] に記録しました」と報告

#### 🎯 記録品質向上ポイント
- **具体性重視**: 抽象的ではなく具体的なデータ・手順・結果を記録
- **再現性確保**: 他の人が読んでも同じ結果を得られる詳細度
- **戦略的価値**: プロジェクト全体にとっての意味・価値を明確化
- **継続的改善**: 記録内容を次回活用できる形で整理

## 🔥 音楽制作プロンプト技法

### 革命的技法「装飾語マシマシ + 繰り返し強調 + ループ最適化」
```
[感情装飾語3つ] + 8-bit chiptune [テーマ] + [音源] + [楽器 楽器 楽器] + [テンポ テンポ テンポ] + [雰囲気 雰囲気 雰囲気] + SEAMLESS LOOP [ループ特化指定]
```

### 🔄 ループミュージック技法（2025年重要発見）
**重要**: ゲーム音楽・作業BGMとしての実用性を劇的向上させる技法

#### ループ特化プロンプト要素
```
必須要素:
"SEAMLESS LOOP perfect for extended listening", "designed for 30+ minute continuous play", "maintains interest over repetition", "game music loop structure", "concentration-friendly composition", "background music optimized"

強化要素:
"cyclical harmonic progression", "smooth transitions", "immersive atmosphere maintenance", "streamer and content creator ready", "cognitive flow support", "emotional consistency throughout"
```

#### 実用価値
- **ゲーム制作者需要**: 実際に使用されるBGM品質
- **配信者活用**: 長時間ストリーミング対応
- **作業BGM**: 集中力維持・生産性向上効果
- **再生時間延長**: リピート率向上で総視聴時間増加

### 装飾語戦略マップ
#### 平和・癒し系楽曲
- **第1装飾語**: Peaceful, Serene, Tranquil, Calming, Soothing
- **第2装飾語**: Gentle, Soft, Tender, Warm, Cozy
- **第3装飾語**: Dreamy, Sleepy, Restful, Quiet, Hushed

#### エピック・戦闘系楽曲
- **第1装飾語**: Epic, Heroic, Triumphant, Legendary, Majestic
- **第2装飾語**: Powerful, Bold, Fierce, Thunderous, Blazing
- **第3装飾語**: Victorious, Glorious, Ultimate, Supreme, Invincible

#### 神秘・ファンタジー系楽曲
- **第1装飾語**: Ethereal, Mystical, Enchanting, Magical, Divine
- **第2装飾語**: Floating, Sparkling, Shimmering, Twinkling, Celestial
- **第3装飾語**: Heavenly, Sacred, Blessed, Angelic, Transcendent

### カテゴリ別プロンプト実例
#### Sleep Music 特化
```
Peaceful, serene, tranquil 8-bit chiptune village lullaby, dreamy Game Boy DMG sound, gentle gentle gentle square wave melody, soft soft soft triangle wave bass, slow slow slow tempo, warm major key, cozy evening RPG town theme, sleepy sleepy sleepy atmosphere
```

#### Battle Music 特化
```
Epic, heroic, triumphant 8-bit chiptune final battle, powerful NES sound chip, bold bold bold square wave lead, thunderous thunderous thunderous triangle bass, blazing blazing blazing tempo, legendary boss encounter, victorious victorious victorious destiny awaits
```

### 技術的メカニズム
#### なぜ装飾語マシマシが効果的か
1. **感情レイヤーの重層化**: 3つの装飾語で深い感情表現
2. **Sunoの理解促進**: 複数の類似語で意図を明確化
3. **ニュアンスの精密化**: 微細な感情差を表現可能
4. **予期しない創造性**: 装飾語組み合わせが新表現を生む

#### なぜ繰り返し強調が効果的か
1. **重要度の明確化**: Sunoに最重要要素を確実に伝達
2. **実装確実性**: 繰り返しで意図した特性を確実に実現
3. **安定性向上**: ランダム要素を減らし狙った結果を確保
4. **品質保証**: 期待通りの楽曲特性を確実に獲得

## YouTube コンテンツ戦略

### 2日間集中投稿システム
1. **Day 1**: Complete Collection（フル動画・長尺版）投稿
2. **Day 2**: 全楽曲を個別動画として一斉投稿 + 再生リスト作成
3. 次のコレクションサイクル開始

### 概要欄作成ルール
- ナレッジのテンプレートに厳密準拠
- タイムスタンプ付き楽曲リスト必須
- 内部循環システム（11コレクション相互誘導）完備
- SEO 最適化（RELATED SEARCHES + ハッシュタグ）

### 内部循環戦略
```
FROM THE COMPLETE COLLECTION: フル動画への誘導
COMPLETE ADVENTURE SERIES: 全11コレクションへの循環
```

## 記録システム

### documentation/awareness/ ディレクトリ
- プロジェクト進行中の重要な気づき・学びを記録
- ファイル名: `YYYYMMDD-タイトル.md`

### documentation/working/ ディレクトリ（廃止予定）
- **移行済み**: 各コレクション内 20-documentation/ に分散管理
- **残存用途**: 汎用テンプレート・学習記録の一時保管
- **完全廃止予定**: Phase 3で documentation/working/ 完全廃止

### 新規コンテンツの命名規則
- `YYYYMMDD-STATUS-TYPE-NAME/`
- STATUS: LIVE（投稿済み）, READY（投稿準備完了）, PROD（制作中）, PLAN（企画中）
- TYPE: collection（コレクション）, individual（個別楽曲）, special（特別企画）
- 例: `20250817-READY-collection-ocean-adventure`

## Git ワークフロー

### コミットメッセージ形式
```
feat: [コレクション名] [主要な成果]

📊 [具体的な数値・実績]
✅ [完了項目リスト]
🎯 [戦略的価値・インパクト]

🤖 Generated with [Claude Code](https://claude.ai/code)
Co-Authored-By: Claude <noreply@anthropic.com>
```

## プロジェクト固有ルール

### 時間データ処理
- macOS 環境での `afinfo` 使用が前提
- 必ず実ファイルから正確な時間を取得
- YouTube チャプター機能対応のタイムスタンプ生成

### ブランド統一
- 「8-Bit Adventure Hub」の表記統一
- 概要欄の絵文字・構成は ナレッジテンプレート準拠
- サムネイル文言はモバイル視認性を重視

### 作業効率化
- 複数ファイル処理は bash の for ループ活用
- Python による時間計算の自動化
- ナレッジベース参照による品質保証

## 📊 完成済みコレクション一覧（11コレクション）

**全コレクションの統合管理**: `collections/live/` ディレクトリにて統一管理

### 1. Adventure Music (24曲・1:00:00) ✅
- **URL**: https://youtu.be/j3VYctGmZTE
- **特徴**: 冒険→戦闘の流れで完璧な物語性
- **戦略価値**: チャンネルの基礎を築いた記念すべき第1作

### 2. Battle Music (13曲・1:00:00) ✅
- **URL**: https://youtu.be/BDgtysOgcmQ
- **特徴**: 戦闘特化、段階的盛り上がり構成
- **戦略価値**: アクション需要の完全制覇

### 3. Dungeon Music (16曲・1:00:00) ✅
- **URL**: https://youtu.be/Imwkjvx-7bc
- **特徴**: 神話的魅力のダンジョン名
- **戦略価値**: 雰囲気音楽の決定版

### 4. Village & Town Music (18曲・1:20:00) ✅
- **URL**: https://youtu.be/V02uDsf7bZE
- **特徴**: 時間の流れ構成（朝→昼→夜→祭り）
- **戦略価値**: 日常BGM需要の完全制覇

### 5. Japanese RPG Music (22曲・1:30:00) ✅
- **URL**: https://youtu.be/aZKtTPszKPo
- **特徴**: 忍者と侍の壮大な物語
- **戦略価値**: 文化的橋渡しの傑作

### 6. Emotional Journey Music (20曲・1:30:00) ✅
- **URL**: https://youtu.be/g8uKX0sEugk
- **特徴**: 感情ジェットコースター設計
- **戦略価値**: 感動系チップチューンのパイオニア作品

### 7. Shop & Inn Music (20曲・1:00:00+) ✅
- **URL**: https://youtu.be/6xSV8IebioM
- **特徴**: 商店街の完全体験
- **戦略価値**: 生活密着型BGMの決定版

### 8. Sleep & Dream Music (26曲・1:30:00) ✅
- **URL**: https://youtu.be/wPdfqSoXqjE
- **特徴**: 睡眠誘導・リラクゼーション
- **戦略価値**: ウェルビーイング市場の新領域

### 9. RPG Class Music (20曲・1:23:22) ✅
- **URL**: https://youtu.be/YPMwKYVET1s
- **特徴**: RPGの20職業を音楽で表現
- **戦略価値**: ゲーミングコミュニティへの新規参入

### 10. Boss Rush Music (18曲・1:14:22) ✅
- **URL**: https://youtu.be/d2jCGRorxDM
- **特徴**: 18体のボス戦BGM
- **戦略価値**: 戦闘音楽の極致

### 11. Adventure Season 2 (37曲・3:50:32) ✅
- **URL**: https://youtu.be/VwBFfA5sr9s
- **特徴**: 史上最大ボリューム・完璧な物語性
- **戦略価値**: プロジェクトの集大成
- **ディレクトリ**: `20250816-LIVE-collection-adventure-season-2/`

### 12. Guild & Quest Collection (20曲・1:40:44) ✅
- **URL**: https://youtu.be/nYCLeMcJL2k
- **特徴**: RPGシステム音楽の先駆者・ギルド成長ストーリー
- **戦略価値**: D&D・TTRPG界隈への新規参入
- **ディレクトリ**: `20250818-LIVE-collection-guild/`

### 13. World Map Collection (22曲・1:30:16) ✅
- **URL**: https://youtu.be/6D_ph8hNwNY
- **特徴**: ファンタジー世界完全探索・地理的ストーリーテリング
- **戦略価値**: RPG制作者・世界構築コミュニティへの完全対応
- **ディレクトリ**: `20250820-LIVE-collection-world-map/`
- **投稿日**: 2025-08-17 投稿予約完了

### プレイリストURL
- **🗡️ Adventure**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtWJht-NRs3n88P-lBRWW9sS
- **⚔️ Battle**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtWLGF4Cwg7-Q1Fjs20oXSKO
- **🏰 Dungeon**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtU9OMl5P7Hrw1890yIu1YOR
- **🏘️ Village & Town**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtUWBCtaTFt4teZ9RYt5DkTZ
- **🏯 J-RPG**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtUyBEKEhkO7qOJwmkoo6XDy
- **💧 Emotional**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtW3i2qvg2EFRXxeC2vZrd9N
- **🏪 Shop & Inn**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtWzTv26rPJ_hwGIItrXDLFF
- **🌙 Sleep & Dream**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtVa7oVawWnd9L4lr8I5bNIv
- **⚔️ RPG Class**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtVIGA8NSKqkaGBFVZTTI1iV
- **🔥 Boss Rush**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtXL-LMQkHjGQHw-C9VE1z_6
- **🗺️ Adventure Season 2**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtV5ndmyA0RpGf5nB5DlOd1o
- **🏛️ Guild & Quest**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtVamT-y9idRLkx3VhGuUNoE
- **🗺️ World Map**: https://www.youtube.com/playlist?list=PLJ5vG59SMwtWG_614akgF-04ULrRO3cMS

## 🎨 AI サムネイル制作戦略（2025年革新技法）

### Midjourney 特化プロンプト戦略
**CTR向上**: AI生成により従来比30-40%のクリック率向上実績

#### 基本構造テンプレート
```
[視覚的要素] + [8-bit指定] + [感情・雰囲気] + [技術指定] + [品質向上句]
```

#### 推奨設定
- **アスペクト比**: `--ar 16:9` (YouTube最適化)
- **バージョン**: `--v 6` (最新品質)
- **スタイル**: `--style raw` (8-bit特化)

#### カラー心理学応用
- **赤・オレンジ系**: Adventure, Battle (冒険心・エネルギー)
- **青系**: Sleep, Emotional (信頼性・平静)
- **紫系**: Dungeon, Magic (神秘性・高級感)
- **緑・茶系**: Village, Shop (自然・温かみ)

#### モバイル最適化重要ポイント
- **文字サイズ**: 最小24pt以上
- **コントラスト比**: 4.5:1以上
- **判読距離**: 30cm離れても識別可能

## 📝 YouTube 概要欄テンプレート

### メインプレイリスト用基本構造
```
8-Bit [THEME] Music - Complete [ADJECTIVE] Playlist [EMOJI][EMOJI]

🎵 Welcome to 8-Bit Adventure Hub! 🎵

Experience the complete collection of [XX] individual tracks from our 8-Bit BGM [X.X]-hour [THEME] that will take you through every [EXPERIENCE_TYPE]! Each track is now available separately, perfect for finding your exact favorite [MOMENT_TYPE] or creating custom [THEME] playlists for any mood! [EMOJI]➡️[EMOJI]

[THEME_ICON] FROM THE 8-Bit BGM [COLLECTION_NAME]:
This playlist features all [XX] tracks from our complete [X.X]-hour [ADJECTIVE] masterpiece:
➤ **Full**: https://youtu.be/[MAIN_VIDEO_URL]

🛡️ PERFECT FOR:
✅ Deep study sessions & extended focus time ([X.X] hours)
✅ Tabletop RPG [SPECIFIC] scenes & D&D [ENCOUNTER_TYPE] encounters
✅ Game development & retro RPG project atmosphere
✅ Creative writing & storytelling projects ([SCENE_TYPE] scenes)
✅ Background music for gaming streams & content creation
✅ Nostalgic relaxation & RPG memory immersion
✅ Productivity sessions with [ADJECTIVE] [THEME] vibes
✅ Custom playlist creation for different [THEME] moods

🎯 ABOUT 8-BIT ADVENTURE HUB:
Your ultimate destination for 8-Bit BGM chiptune adventures! This [THEME] playlist showcases the power of music to [ACTION] through our signature [QUALITY1] melodies, [QUALITY2] harmonies, and [QUALITY3] crescendos.

📱 CONNECT WITH US:
🔔 Subscribe for daily 8-Bit BGM adventures!
👍 Like your favorite [THEME] tracks!
💬 Comment which song [ACTION_PAST] your heart most!
🔄 Share with someone who [NEEDS_WHAT] today!

🎮 COMPLETE ADVENTURE SERIES:
[全11コレクションへのリンク配置]

📝 LICENSE & USAGE:
This music is original AI composition. Free to use for:
- Gaming streams & videos (with attribution)
- [SPECIFIC] content & [ADJECTIVE] videos
- Personal [USE_CASE] & [USE_CASE]
- [ACTIVITY] sessions & focus work

For commercial licensing, contact us!

🎵 [THEME] MASTERY:
From [EXAMPLE_FIRST] to [EXAMPLE_LAST], each track represents a crucial moment in the [EXPERIENCE_TYPE]. Create your perfect [ADJECTIVE] journey by selecting exactly the [ELEMENTS] and moments that match your current [STATE]'s needs!

🔍 RELATED SEARCHES:
[theme] music playlist, [adjective] [genre] collection, [specific] music tracks, [activity] music playlist, [atmosphere] music collection

日本の皆様へ:
本格的な8ビット[THEME]音楽の全[XX]曲を個別にお楽しみいただけるプレイリストです！

#8BitMusic #[THEME]Music #[ADJECTIVE]Music #StudyBGM #[SPECIFIC]Music #8BitAdventureHub #[ATMOSPHERE]Music #RPGMusic #[QUALITY]Music #Playlist
```

### SEO最適化戦略
#### プライマリーキーワード
- **8-bit music**: 月間検索数最大のコアキーワード
- **chiptune study**: 勉強用需要の直撃キーワード
- **RPG music**: ゲーム音楽の中核キーワード
- **study BGM**: 日本語圏での主要需要

#### ハッシュタグ戦略
基本セット（全動画共通）:
```
#8BitMusic #ChiptuneStudy #StudyBGM #8BitAdventureHub #RPGMusic #GamingMusic
```

## 🎨 サムネイル & ブランディング戦略

### ブランドパーソナリティ
- **Epic**: 壮大で記憶に残る体験
- **Nostalgic**: 懐かしくて心温まる
- **Reliable**: 安定した高品質の保証
- **Innovative**: 常に新しい技術と表現を追求

### カラーパレット
- **プライマリー**: 8-bit風のビビッドカラー（緑、青、赤、黄）
- **セカンダリー**: 温かみのあるアース系（茶、オレンジ、深緑）
- **アクセント**: 魔法的な紫、神秘的な水色
- **ベース**: クリーンな黒・白・グレー

### AI生成プロンプト戦略
#### Adventure系
```
Epic 8-bit pixel art RPG adventure scene, lone hero standing on hilltop overlooking vast fantasy landscape, golden sunset sky, retro game aesthetic, Game Boy color palette, detailed pixel art style, nostalgic gaming atmosphere, wide vista with distant mountains, small villages below, sense of beginning great journey
```

#### Battle系
```
Intense 8-bit pixel art battle scene, heroic warrior facing massive dragon, dynamic action pose, NES-style sprite art, vibrant battle effects, lightning and fire, classic RPG boss encounter, dramatic lighting, 16-bit color palette, epic confrontation atmosphere
```

## 🎯 戦略的優先事項

### 成功の核心要素
- **装飾語マシマシ技法**: 3つの感情装飾語で深い表現
- **繰り返し強調**: gentle gentle gentle, slow slow slow で確実な実装
- **ストーリーテリング**: 成長物語（novice → legendary hero）
- **完璧な内部循環**: Full Collection + Complete Playlist の2段階誘導

### 現在のフォーカス
1. **個別楽曲の再生リスト展開** - 2日間投稿システムの完全実装
2. **内部循環最大化** - FROM THE COMPLETE COLLECTIONによる相互流入強化
3. **感情訴求強化** - Emotional Journey準拠の没入感ある説明文
4. **SEO最適化** - RELATED SEARCHES + ハッシュタグ戦略の完全実装

### 次期企画戦略（2025年8月企画）
#### 🏛️ 最優先: Guild & Quest Collection
- **戦略的価値**: D&D・TTRPG界隈で巨大需要、競合絶対優位
- **期待CTR**: 1.8%+（RPG特化による高エンゲージメント）
- **楽曲構成**: ギルド登録→クエスト→達成の20楽曲成長ストーリー

#### 🎓 第2推奨: Academy & Magic School Collection  
- **戦略的根拠**: Adventure系成功要因継承（CTR 2.35%実績）
- **感情訴求**: 青春ノスタルジア・成長物語の普遍的魅力
- **技術革新**: Academy特化装飾語マップ・5部構成物語設計
- **楽曲構成**: 入学→学習→冒険→成長→特別編の25楽曲

#### 🌊 第3候補: Ocean & Sea Adventure Collection
- **Adventure系拡張**: 海洋冒険の壮大スケール
- **未開拓環境**: 海・水中テーマは8-bit音楽で希少
- **物語性**: 船出→嵐→海戦→海底神殿→伝説の島発見

### 技術的優位性の維持
- **模倣困難**: 装飾語選択の高度な感性要求
- **品質差別化**: 従来手法を大幅上回るクオリティ
- **安定性**: 狙った結果を確実に出せる再現性
- **唯一無二**: 他チャンネル未使用の革命的手法

## 🎓 重要な学習・発見（2025年8月統合）

### 📊 YouTube パフォーマンス分析（2025-08-16）
#### 現在の成果
- **総視聴回数**: 3,062回
- **総再生時間**: 101.88時間
- **新規登録者**: 40人
- **平均CTR**: 0.58%

#### トップパフォーマー
1. **Adventure Music**: 146回・CTR 2.35%
2. **Dungeon Music**: 115回・CTR 1.45%
3. **RPG Class Music**: 114回・CTR 0.71%

#### 戦略的発見
- **長時間コレクション圧勝**: 1時間以上の動画が安定した高パフォーマンス
- **Boss Battle系異常高CTR**: 5-7%台の驚異的数値
- **Adventure系成功要因**: 物語性・感情訴求・完璧な構成

### 🔧 技術的革新
1. **ループミュージック技法**: ゲーム音楽としての実用性を劇的向上
   - 30分以上の連続再生対応
   - 配信者・ゲーム制作者需要に直撃
   - 再生時間延長効果による収益向上

2. **AI サムネイル制作**: CTR 30-40%向上実績
   - Midjourney v6 + カラー心理学
   - モバイル最適化重視設計
   - A/Bテスト対応バリエーション制作

3. **装飾語マシマシ技法**: 音楽品質の安定化
   - 3つの感情装飾語による深い表現
   - 繰り返し強調による確実な実装
   - 競合模倣困難な高度技法
   - Academy特化装飾語マップ等テーマ別体系化

### 📂 運営システム改革
1. **分散型作業文書管理**: プロジェクト効率化
   - 各コレクション内 20-documentation/ 導入
   - 自己完結型によるコンテキスト保持
   - グローバル working ディレクトリ廃止
   - プロジェクト切り替え時の文脈維持・作業効率向上

2. **2日間集中投稿システム**: 最適な投稿戦略
   - Day 1: Complete Collection投稿
   - Day 2: 全楽曲個別投稿 + プレイリスト作成
   - 視聴者選択肢最大化とSEO効果両立

3. **日付プレフィックス管理**: スケジュール可視化
   - `YYYYMMDD-STATUS-TYPE-NAME/` 命名規則
   - 投稿予定・進捗状況の即座把握
   - 拡張性確保した柔軟システム

4. **プレイリスト概要欄最適化**: 標準フォーマット確立
   - 簡潔性重視・具体例による使用イメージ向上
   - FROM THE構造による明確なフル動画誘導
   - 新フォーマットで内部循環率向上

### 🎯 戦略的発見
1. **RPGシステム音楽需要**: 未開拓の巨大市場
   - Guild & Quest Collection による検証予定
   - ゲーミングコミュニティへの参入価値
   - Adventure Collection超越の可能性
   - D&D・TTRPG界隈での確実需要

2. **内部循環システム**: 視聴時間最大化
   - FROM THE COMPLETE COLLECTION 戦略
   - 11コレクション相互誘導の威力
   - 個別楽曲→フルコレクション誘導効果
   - Boss Rush & Adventure Season 2 URL更新で完全体制

3. **感情ジャーニー設計**: 視聴者エンゲージメント
   - novice adventurer → legendary hero の成長物語
   - 単なるBGMを超えた感動体験提供
   - ブランド差別化の核心要素

4. **アナリティクス駆動企画**: データに基づく戦略決定
   - Adventure系CTR 2.35%・Boss Battle系5-7%の実績活用
   - 長時間コンテンツ（2-4時間）の圧倒的優位性確認
   - Academy & Magic School等新企画の科学的根拠確立

## 📋 品質管理チェックリスト

### 音楽品質チェック
```
音楽内容:
□ テーマとの適合性
□ 8-bit音源の忠実再現
□ 感情表現の深度
□ RPGシーンとの整合性
□ 楽曲タイトルとの一致性
```

### 概要欄品質チェック
```
構造・内容:
□ Emotional Journey準拠フォーマット
□ FROM THE COMPLETE COLLECTION配置
□ PERFECT FOR 8項目 (✅形式)
□ MUSICAL FEATURES詳細説明
□ RELATED SEARCHES配置

リンク・参照:
□ メイン動画URL正確性
□ プレイリストURL正確性
□ 他コレクションURLs更新
□ ハッシュタグ最適化
□ 日本語説明の適切性
```

### サムネイル品質基準
```
技術仕様:
□ 解像度: 1280x720 (HD)
□ アスペクト比: 16:9
□ ファイル形式: JPG (高画質)
□ ファイルサイズ: 2MB以下

デザイン品質:
□ ピクセルアート風ビジュアル
□ テーマ適合カラーパレット
□ モバイル視認性確保
□ ブランド統一性維持
□ 競合との差別化
```

## 🚀 新規企画準備状況

### collections/planning/ 企画管理
```
20250824-planning-collection-academy-magic-school/
├── 20-documentation/
│   └── 20250817-academy-magic-school-suno-prompts.md  # 25楽曲完全プロンプト集
20250826-planning-collection-nostalgia-campfire/
20250828-planning-collection-ocean-sea-adventure/
```

### Guild Collection 投稿準備完了
```
20250818-production-collection-guild/
├── 20-documentation/
│   ├── 20250816-guild-collection-full-description.md      # フル動画用概要欄
│   ├── 20250816-guild-collection-playlist-description.md  # プレイリスト用概要欄
│   └── 20250816-guild-thumbnail-midjourney-prompts.md     # サムネイル素材
```

### 企画選定プロセス最適化
1. **アナリティクス分析** → 成功パターン特定
2. **戦略仮説構築** → CTR・視聴時間予測
3. **企画詳細設計** → 楽曲構成・物語性設計
4. **プロンプト体系作成** → テーマ特化装飾語マップ
5. **制作・投稿実行** → 効果測定・学習記録