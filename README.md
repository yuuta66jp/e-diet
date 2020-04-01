# e-diet
e-dietは食事記録を含む日記を投稿することで、様々なユーザーと繋がる事ができるダイエット支援・交流サイトです。

## 実装機能

### ユーザー関連
- 新規登録機能
- ログイン、ログアウト機能
- テストユーザー機能
- 一覧表示機能
- 編集、退会機能
- 折れ線グラフを用いた体重表示機能

### 日記関連
- 食事記録を含む日記投稿機能
- 日記編集、削除機能
- 食事記録追加、編集、削除機能
- 食事記録への画像投稿機能
- タグ機能
- タグ別表示を含む一覧表示機能

### ポイント関連
- 行動に応じたポイント付与機能
  - 新規登録ポイント
  - ログインポイント（1日1回）
  - 日記投稿ポイント
  - フォローポイント
  - 目標達成ポイント

### コメント関連
- コメント投稿機能(Ajaxを用いた非同期通信)
- コメント削除機能(Ajaxを用いた非同期通信)

### フォロー関連
- フォロー、フォロー解除機能
- フォロワー、フォロー一覧表示機能

### 管理者関連
- トピックス投稿機能
- トッピクス編集、削除機能
- トピックスジャンル作成、編集機能
- ユーザー編集、削除機能
- 日記削除機能

### その他
- bootstrap-sass 3.3.6
- インフラ  
AWS(EC2,RDS,EIP,Route53,ACM,ALB)
- 開発環境  
Vagrant,VirtualBox

## バージョン
Ruby 2.5.7  
Rails 5.2.4.1

## 作者
GitHub: yuuta66jp

## ライセンス
MIT License
