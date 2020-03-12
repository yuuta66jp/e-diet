class Reward < ApplicationRecord
  # アソシエーション設定
  belongs_to :user

  # enum機能の定義
  enum issue_reason: { 新規登録: 0, 日記投稿:1, コメント: 2, フォロー: 3, 目標達成:4 }

end
