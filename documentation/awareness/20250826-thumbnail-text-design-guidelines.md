# 🎨 サムネイル文字デザインガイドライン（CTR最適化版）

## 🎯 設計方針
**モバイル70%視聴 + 誇張表現回避 + CTR最大化**

---

## 📱 モバイル最適化要件（Canva用）

### 📏 文字サイズ基準（Canva設定）
```
メインタイトル: 36px以上 (モバイル必須)
サブタイトル: 28px以上
詳細情報: 24px以上（最小限）
チャンネル名: 20px以上
```

### 🔤 フォント選択（Canva推奨）
```
✅ 推奨: Arial Black, Impact, Montserrat Extra Bold
✅ Canva無料: Bebas Neue, Oswald Bold
❌ 避ける: セリフ体、細字、装飾フォント
```

### 🎨 コントラスト基準（Canva設定）
```
文字 vs 背景: 7:1以上のコントラスト比
境界線: 2px以上の白/黒縁取り（Canvaのアウトライン機能使用）
背景: 半透明オーバーレイ使用推奨（Canvaの背景調整）
```

### 🛠️ Canva作業フロー
```
1. Midjourneyで生成した画像をCanvaにアップロード
2. 1920x1080サイズに設定
3. 文字レイヤーを順次追加
4. モバイルプレビューで視認性確認
5. PNG形式でエクスポート
```

---

## 🏗️ 標準レイアウト（16:9最適化）

### 📋 Complete Collection用テンプレート
```
┌─────────────────────────────┐
│                             │ ← 上部1/3: ビジュアル専用
│        [背景画像]           │
│                             │
├─────────────────────────────┤
│  8BIT BGM                  │ ← 中央: 36px、中央配置
│  [Collection Name]         │ ← 32px、メインタイトル
│  Collection                │ ← 28px、シンプル表記
│                            │
│  [曲数] Tracks • [時間]    │ ← 下部: 24px、事実情報
└─────────────────────────────┘
```

### 📋 Individual Track用（動画内一枚絵使用）
```
Individual Trackは専用サムネイル作成なし
→ 動画内使用の一枚絵をそのままサムネイルに設定

理由:
✅ Complete Collectionとの差別化
✅ 工数削減（22本×サムネ作成作業カット）  
✅ 動画内容とサムネの完全一致
✅ ヒューマンファクター等のCTR要素は動画内一枚絵で対応
```

---

## ✅ 改良版文字戦略

### 🏰 Royal Castle Collection 例

#### Before（誇張版・NG）
```
EPIC ROYAL CASTLE MUSIC
Ultimate Medieval Adventure!
20 LEGENDARY TRACKS
```

#### After（改良版・推奨）
```
8BIT BGM
Royal Castle Collection
20 Tracks • 1:15:00
```

### 🌊 Ocean Adventure Collection 例

#### Before（誇張版・NG）
```
AMAZING OCEAN ADVENTURE!
Epic Maritime Journey Music
ULTIMATE SEA EXPLORATION
```

#### After（改良版・推奨）
```
8BIT BGM  
Ocean Adventure Collection
Maritime Fantasy Music
```

---

## 🎨 視覚的階層構造

### 🥇 Priority 1（最重要）
```
8BIT BGM - ブランド認知
コレクション名 - 内容識別
```

### 🥈 Priority 2（重要）
```  
楽曲数・時間 - 事実情報
ジャンル説明 - 検索対応
```

### 🥉 Priority 3（補助）
```
チャンネルロゴ - ブランド統一
装飾要素 - 視覚的魅力
```

---

## 🚫 デザイン禁止事項

### ❌ 文字関連NG
- 3要素超過の情報詰め込み
- 24px未満の小文字使用
- 低コントラスト配色
- 装飾過多（グラデーション、影効果等）

### ❌ レイアウトNG  
- 中央以外の文字配置
- ビジュアルを遮る文字配置
- 統一感のない文字サイズ

---

## 🔄 A/Bテスト用バリエーション

### 🧪 文字配置テスト

#### Pattern A（中央配置）
```
画像上部2/3 + 下部1/3文字エリア
```

#### Pattern B（左下配置）
```  
全体画像 + 左下角文字オーバーレイ
```

#### Pattern C（右上配置）
```
全体画像 + 右上角文字配置
```

### 🧪 情報量テスト

#### Minimal（最小情報）
```
8BIT BGM
[Collection Name]
```

#### Standard（標準情報）
```
8BIT BGM
[Collection Name] Collection  
[曲数] Tracks
```

#### Detailed（詳細情報）
```
8BIT BGM
[Collection Name] Collection
[曲数] Tracks • [時間]
[ジャンル] Fantasy Music
```

---

## 📊 成功指標・測定方法

### 🎯 定量的指標
- **CTR**: 現在0.5% → 目標2.0%+
- **モバイルCTR**: デスクトップとの差異最小化
- **クリック後維持率**: クリックベイト排除効果

### 👁️ 視認性テスト
- スマートフォンでの5秒判読テスト
- 異なる画面サイズでの確認
- 明度変更環境での視認性確認

---

## 🔧 技術的実装要件

### 🖼️ ファイル仕様
```
解像度: 1920x1080 (16:9)
フォーマット: PNG（透明度対応）
ファイルサイズ: 2MB以下（YouTube推奨）
```

### 🎨 色彩設定
```
背景オーバーレイ: rgba(0,0,0,0.3-0.5)
文字色: #FFFFFF (白) または #000000 (黒)
縁取り: 反対色、2px以上
```

---

**作成日**: 2025年8月26日  
**適用開始**: Royal Castle Collection から  
**検証周期**: 各コレクション投稿後1週間でCTRデータ分析**