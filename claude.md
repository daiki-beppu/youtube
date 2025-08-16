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

### 現在の成果（2025-08-16更新）
- **総制作時間**: 15.7+ 時間
- **総楽曲数**: 271曲（WAVファイル）
- **完成コレクション**: 11つ
- **最新完成**: Adventure Season 2（37楽曲・3:50:32）
- **ディレクトリ改革**: 日付プレフィックス + ステータス管理システム導入済み

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

## アーキテクチャ

### ディレクトリ構造
- `000-xxx/`: 過去の音楽コレクション（001-adventure, 002-battle など）
- `YYYYMMDD-STATUS-TYPE-NAME/`: 新規コンテンツ（日付プレフィックス付き）
- `documentation/`: プロジェクト戦略・ノウハウ・記録の統合管理
  - `knowledges/`: 体系化された知識ベース
  - `awareness/`: プロジェクト進行中の気づき・学びの記録
  - `working/`: 作業中ファイル・一時的な成果物
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
└── 10-thumbnail/        # サムネイル素材
```

## マスターナレッジベースシステム

### 必須確認事項
1. **回答前に必ずマスターナレッジベース確認**: `documentation/00-unified-knowledge-base.md` を参照
2. **ファイル構成の実態確認**: 楽曲リスト・時間データ作成時は必ず実ファイルを確認
3. **時間表記統一**: 1時間未満 `xx:xx` / 1時間以上 `x:xx:xx` 形式厳守

### ナレッジファイル構成
- `documentation/00-unified-knowledge-base.md`: 統合知識ベース（必ず最初に参照）
- 全ての旧ナレッジファイルが統合済み
- 新しい学びは `documentation/awareness/` で記録
- 作業中資料は `documentation/working/` で管理

## 🔥 音楽制作プロンプト技法

### 革命的技法「装飾語マシマシ + 繰り返し強調」
```
[感情装飾語3つ] + 8-bit chiptune [テーマ] + [音源] + [楽器 楽器 楽器] + [テンポ テンポ テンポ] + [雰囲気 雰囲気 雰囲気]
```

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

### documentation/working/ ディレクトリ  
- 作業中の一時ファイル・成果物
- 概要欄ドラフト、プロンプト集、分析資料など

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
- **特徴**: 18体のボス戦BGM
- **戦略価値**: 戦闘音楽の極致

### 11. Adventure Season 2 (37曲・3:50:32) ✅
- **URL**: 投稿後に追加予定
- **特徴**: 史上最大ボリューム・完璧な物語性
- **戦略価値**: プロジェクトの集大成
- **ディレクトリ**: `20250816-LIVE-collection-adventure-season-2/`

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

### 技術的優位性の維持
- **模倣困難**: 装飾語選択の高度な感性要求
- **品質差別化**: 従来手法を大幅上回るクオリティ
- **安定性**: 狙った結果を確実に出せる再現性
- **唯一無二**: 他チャンネル未使用の革命的手法

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