# 📅 ディレクトリ構造改革 - 日付プレフィックス導入計画

*作成日: 2025-08-16*

## 🎯 現状分析

### 現在のディレクトリ構造の課題
1. **投稿スケジュール管理困難**: どれがいつ投稿予定かわからない
2. **進捗状況不明**: 制作中・完成・投稿済みの区別がつかない  
3. **番号体系の限界**: 012, 013... と続くと管理が煩雑
4. **緊急対応困難**: 急な投稿順変更に対応しにくい

### 成功している部分
- 200-docs配下は既に日付プレフィックスを部分使用
- awareness/, working/ ディレクトリのファイル命名は良好
- 01-master/, 02-Individual-music/, 03-Individual-movie/ の内部構造は統一

## 🚀 新ディレクトリ戦略

### 基本方針
```
[YYYYMMDD]-[STATUS]-[CONTENT-TYPE]-[NAME]

例:
20250816-READY-collection-adventure-season-3
20250820-PROD-individual-dawn-of-legends  
20250825-PLAN-collection-seasonal-winter
```

### STATUS定義
- **PLAN**: 企画・構想段階
- **PROD**: 制作中
- **READY**: 投稿準備完了
- **LIVE**: 投稿済み・公開中
- **ARCH**: アーカイブ・過去コンテンツ

### CONTENT-TYPE定義
- **collection**: メインコレクション（20+楽曲の長尺）
- **individual**: 個別楽曲展開
- **analysis**: 分析・レポート類
- **operation**: 運営業務
- **template**: テンプレート・素材

## 📁 新ディレクトリ構造設計

```
/8BAH-Project/
├── collections/
│   ├── 20250816-LIVE-collection-adventure-season-2/
│   ├── 20250823-READY-collection-boss-rush-2/
│   ├── 20250830-PROD-collection-seasonal-winter/
│   └── 20250906-PLAN-collection-overworld-music/
│
├── individuals/
│   ├── daily-posts/
│   │   ├── 20250816-READY-individual-dawn-of-legends/
│   │   ├── 20250817-READY-individual-village-of-destiny/
│   │   └── 20250818-READY-individual-emerald-plains/
│   └── archives/
│       └── 20250801-ARCH-adventure-s1-individuals/
│
├── operations/
│   ├── analytics/
│   │   ├── 20250815-weekly-performance-review.md
│   │   └── 20250801-monthly-growth-analysis.md
│   ├── seo-content/
│   │   ├── 20250816-description-templates/
│   │   └── 20250810-hashtag-research/
│   └── thumbnails/
│       ├── 20250816-adventure-s3-designs/
│       └── 20250820-winter-collection-concepts/
│
├── documentation/
│   ├── knowledge-base/
│   │   └── 00-unified-knowledge-base.md (マスター)
│   ├── awareness/
│   │   ├── 20250816-directory-restructure-insights.md
│   │   └── 20250815-adventure-s2-completion.md
│   └── working/
│       ├── 20250816-next-collection-planning.md
│       └── 20250820-thumbnail-batch-creation.md
│
└── resources/
    ├── templates/
    │   ├── prompt-templates/
    │   ├── description-templates/
    │   └── thumbnail-templates/
    └── assets/
        ├── logos/
        ├── brand-colors/
        └── reference-materials/
```

## 📅 移行スケジュール（段階的実施）

### Phase 1: 新規コンテンツから適用（即日開始）
1. **011-adventure-2 → 20250816-LIVE-collection-adventure-season-2/**
2. **次期コレクション → 20250823-PROD-collection-[新テーマ]/**
3. **個別楽曲投稿 → 20250817-READY-individual-[楽曲名]/**

### Phase 2: 運営ファイルの整理（1週間以内）
1. **200-docs/ → documentation/ への移行**
2. **working/ ファイルの日付統一**
3. **新しいanalytics/ ディレクトリ作成**

### Phase 3: 過去コレクションの整理（2週間以内）
1. **001-adventure → 20250701-ARCH-collection-adventure-season-1/**
2. **002-battle → 20250708-ARCH-collection-battle-music/**
3. **順次アーカイブ化・整理**

### Phase 4: 完全移行完了（1ヶ月以内）
1. **全ディレクトリの新体系完成**
2. **CLAUDEmd更新・手順書完成**
3. **運用ルール確立**

## 🎯 実践的命名例

### 今後の投稿予定（例）
```
collections/
├── 20250816-LIVE-collection-adventure-season-2/
├── 20250823-READY-collection-boss-rush-2/
├── 20250830-PROD-collection-winter-wonderland/
├── 20250906-PLAN-collection-overworld-exploration/
└── 20250913-PLAN-collection-emotional-season-2/

individuals/daily-posts/
├── 20250817-READY-individual-village-of-destiny/
├── 20250818-READY-individual-emerald-plains-hope/
├── 20250819-READY-individual-summit-of-gods/
├── 20250820-READY-individual-fortress-of-sky/
└── 20250821-READY-individual-citadel-of-clouds/

operations/
├── 20250816-thumbnail-adventure-s3-batch/
├── 20250820-seo-winter-collection-prep/
├── 20250825-analytics-august-final-report/
└── 20250830-planning-september-strategy/
```

## 🔄 運用ルール

### 日付の決め方
1. **投稿予定日**: YouTubeにアップロード予定の実際の日付
2. **バッファ**: 実際の準備完了日より1-2日余裕を見る
3. **緊急時**: `20250816-URGENT-hotfix-[内容]` で例外対応

### STATUS変更のタイミング
```
PLAN → PROD: 制作開始時
PROD → READY: 投稿準備（動画・説明文・サムネイル）完了時
READY → LIVE: YouTube投稿完了時
LIVE → ARCH: 個別展開完了・次期コンテンツ重視時
```

### フォルダ移動のルール
- STATUS変更時は**リネーム**で対応（フォルダ移動不要）
- ファイル内容は変更しない
- Git履歴を保持

## 📈 期待効果

### 即座の効果
- **投稿スケジュール明確化**: いつ何を投稿するか一目瞭然
- **進捗管理改善**: 制作状況が視覚的に把握可能
- **緊急時対応力向上**: 投稿順変更が容易

### 中長期効果
- **制作効率向上**: どこに何があるかすぐわかる
- **品質管理強化**: ステータス管理で見落とし防止
- **拡張性確保**: 新しいコンテンツタイプにも対応可能

## 🚀 Next Actions

1. **即日実行**: 011-adventure-2 を新体系でリネーム
2. **週内実行**: 新規コンテンツから新命名規則適用
3. **月内完了**: 全体移行完了・運用開始

---

**この日付プレフィックス戦略で、8-Bit Adventure Hub の運営効率を劇的に改善するで！** 📅✨