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
  enum intake_status: { その他: 0, 朝食: 1, 昼食: 2, 夕食: 3, 間食: 4 }

end
