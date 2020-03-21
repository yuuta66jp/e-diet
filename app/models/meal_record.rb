class MealRecord < ApplicationRecord
  # アソシエーション設定
  belongs_to :diary

  # attachmentメソッド（gem:refile)使用
  attachment :meal_image

  # バリデーション設定
  validates :title,         presence: true, length: { maximum: 30 }
  validates :meal_image,    presence: true
  validates :intake_status, presence: true

  # enum機能の定義
  enum intake_status: { 朝食: 0, 昼食: 1, 夕食: 2, 間食: 3 }

end
