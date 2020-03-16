class Reward < ApplicationRecord
  # アソシエーション設定
  belongs_to :user

  # enum機能の定義
  enum issue_reason: { 新規登録: 0, ログイン: 1, 日記投稿:2, コメント: 3, フォロー: 4, 目標達成:5 }

  # 取得ポイントの合計値を計算
  def self.total_point
    self.all.sum(:point)
  end

end
