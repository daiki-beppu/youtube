# 🔄 ディレクトリ移行 - ステップバイステップ実行手順

*作成日: 2025-08-16*

## 🎯 移行実行プラン

### Phase 1: 即日実行（今日中）

#### 1-1. 現在進行中のAdventure Season 2 対応
```bash
# 現在のディレクトリ
011-adventure-2/

# 新しい名前に変更
20250816-LIVE-collection-adventure-season-2/
```

**実行手順:**
1. ディレクトリ名を変更
2. 内部構造はそのまま維持
3. CLAUDE.md の参照先を更新

#### 1-2. 次期コンテンツの命名確定
```bash
# 次に制作予定のコレクション
20250823-PROD-collection-[新テーマ名]/

# 個別楽曲の日次投稿
20250817-READY-individual-village-of-destiny/
20250818-READY-individual-emerald-plains-hope/
20250819-READY-individual-summit-of-gods/
```

### Phase 2: 週内実行（8/16-8/23）

#### 2-1. operations ディレクトリ新設
```bash
mkdir operations/
mkdir operations/analytics/
mkdir operations/seo-content/
mkdir operations/thumbnails/
mkdir operations/scheduling/
```

#### 2-2. documentation 統合
```bash
# 現在の 200-docs/ を documentation/ に移行
mv 200-docs/ documentation/

# 内部整理
documentation/
├── knowledge-base/
│   └── 00-unified-knowledge-base.md
├── awareness/
│   └── [既存の日付ファイル群]
└── working/
    └── [既存の日付ファイル群]
```

#### 2-3. 個別楽曲管理体系構築
```bash
mkdir individuals/
mkdir individuals/daily-posts/
mkdir individuals/ready-queue/
mkdir individuals/archives/
```

### Phase 3: 2週間以内（8/16-8/30）

#### 3-1. 過去コレクションのアーカイブ化
```bash
# 投稿完了済みコレクションを日付付きアーカイブに
001-adventure/ → 20250701-ARCH-collection-adventure-season-1/
002-battle/ → 20250708-ARCH-collection-battle-music/
003-dungeon/ → 20250715-ARCH-collection-dungeon-exploration/
004-village/ → 20250722-ARCH-collection-village-town/
005-j-rpg/ → 20250729-ARCH-collection-japanese-rpg/
006-emotional/ → 20250805-ARCH-collection-emotional-journey/
007-shop-and-inn/ → 20250812-ARCH-collection-shop-inn/
008-sleep-dream/ → 20250819-ARCH-collection-sleep-dream/
009-class/ → 20250826-ARCH-collection-rpg-class/
010-boss-rush/ → 20250802-ARCH-collection-boss-rush/
```

#### 3-2. collections ディレクトリ構築
```bash
mkdir collections/
mkdir collections/live/      # 現在公開中
mkdir collections/ready/     # 投稿準備完了
mkdir collections/production/ # 制作中
mkdir collections/planning/  # 企画段階
mkdir collections/archives/  # 過去作品
```

## 📋 詳細実行チェックリスト

### Phase 1 チェックリスト（今日中）
- [ ] 011-adventure-2/ を 20250816-LIVE-collection-adventure-season-2/ にリネーム
- [ ] CLAUDE.md のパス参照を更新
- [ ] 次期コレクションの投稿日程を確定
- [ ] 個別楽曲の投稿スケジュール作成
- [ ] awareness/ に本日の移行作業記録を作成

### Phase 2 チェックリスト（週内）
- [ ] operations/ ディレクトリ群を新設
- [ ] 200-docs/ を documentation/ にリネーム
- [ ] individuals/ ディレクトリ群を新設
- [ ] 現在の working/ ファイルを新体系で整理
- [ ] テンプレートファイル群を resources/ に移設

### Phase 3 チェックリスト（2週間以内）
- [ ] 過去コレクション10個をアーカイブ体系にリネーム
- [ ] collections/ 管理体系を完全構築
- [ ] 全パス参照の整合性確認
- [ ] 新運用ルールの documentation/ 作成
- [ ] awareness/ に移行完了レポート作成

## 🎯 実行コマンド例

### macOS/Linux での実行例
```bash
# カレントディレクトリを確認
cd /Users/macmini/Dropbox/08-youtube/01-8BAH/

# Phase 1: Adventure Season 2 のリネーム
mv "011-adventure-2" "20250816-LIVE-collection-adventure-season-2"

# Phase 2: 新ディレクトリ構造作成
mkdir -p operations/{analytics,seo-content,thumbnails,scheduling}
mkdir -p individuals/{daily-posts,ready-queue,archives}
mkdir -p collections/{live,ready,production,planning,archives}
mkdir -p resources/{templates,assets}

# Phase 2: ドキュメント移行
mv "200-docs" "documentation"

# Phase 3: アーカイブ化（例）
mv "001-adventure" "20250701-ARCH-collection-adventure-season-1"
mv "002-battle" "20250708-ARCH-collection-battle-music"
```

## 📅 投稿スケジュール管理の新体系

### 日次投稿管理
```
individuals/daily-posts/
├── 20250817-READY-individual-village-of-destiny/
│   ├── audio.wav
│   ├── video.mp4
│   ├── thumbnail.jpg
│   ├── description.txt
│   └── metadata.json
├── 20250818-READY-individual-emerald-plains-hope/
└── 20250819-READY-individual-summit-of-gods/
```

### 週次コレクション管理
```
collections/
├── 20250816-LIVE-collection-adventure-season-2/     # 今週公開
├── 20250823-READY-collection-boss-rush-2/          # 来週投稿準備完了
├── 20250830-PROD-collection-winter-wonderland/     # 再来週制作中
└── 20250906-PLAN-collection-overworld-exploration/ # 企画段階
```

## 🔧 移行時の注意点

### ファイル整合性確保
1. **リネーム前にバックアップ**: 重要ファイルは事前にコピー
2. **パス参照の更新**: CLAUDE.md, プレイリスト説明文等
3. **Git 履歴保持**: git mv コマンドで移動（可能な場合）
4. **段階的実行**: 一度に全部変更せず、フェーズ分けで実行

### 運用継続性
1. **既存ワークフローの維持**: 制作プロセスは変更しない
2. **テンプレート更新**: 新パス構造に合わせてテンプレート修正
3. **チーム共有**: 新ルールの関係者への共有
4. **ドキュメント更新**: 運用マニュアルの即座更新

## 📊 移行効果の測定

### 効率改善指標
- **ファイル探索時間**: 目的ファイルへのアクセス時間短縮
- **投稿準備時間**: スケジュール管理・準備作業の効率化
- **エラー率**: 投稿予定日間違い・ファイル紛失の削減

### 成功基準
1. **1週間後**: 新体系での円滑な日次投稿実現
2. **2週間後**: 過去コンテンツの完全整理完了
3. **1ヶ月後**: 新規コンテンツ制作効率20%向上

## 🚀 Next Actions（優先順）

### 今日中に実行
1. **011-adventure-2 リネーム**
2. **CLAUDE.md パス更新**
3. **明日以降の投稿スケジュール確定**

### 明日から実行
1. **個別楽曲の日付管理開始**
2. **新ディレクトリ構造の段階的構築**
3. **awareness/ に作業ログ記録開始**

---

**この移行計画で、8-Bit Adventure Hub の運営を次のレベルに押し上げるで！** 🚀📅