class Diary < ApplicationRecord

  # アソシエーション設定
  belongs_to :user
  has_one    :body_weight
  has_many   :meal_records, dependent: :destroy

  # enum機能の定義
  enum activity_status: { 低い: 0, 普通: 1, 高い: 2 }

  end
