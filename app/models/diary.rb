class Diary < ApplicationRecord

  # アソシエーション設定
  belongs_to :user
  has_one    :body_weight,  dependent: :destroy
  has_many   :meal_records, dependent: :destroy

  # enum機能の定義
  enum activity_status: { 低い: 0, 普通: 1, 高い: 2 }

  # タグ機能
  # acts_as_taggable_on :tagsと同じ意味（エイリアス）
  acts_as_taggable

  end
