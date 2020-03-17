class Diary < ApplicationRecord
  # アソシエーション設定
  belongs_to :user
  has_one    :body_weight,    dependent: :destroy
  has_many   :meal_records,   dependent: :destroy
  has_many   :diary_comments, dependent: :destroy

  # バリデーション設定
  # :onオプションでupdate時のみバリデーションを設定
  validates :activity_status, presence: true, on: :update
  validates :created_on,      presence: true


  # enum機能の定義
  enum activity_status: { 低い: 0, 普通: 1, 高い: 2 }

  # タグ機能
  # acts_as_taggable_on :tagsと同じ意味（エイリアス）
  acts_as_taggable

  end
