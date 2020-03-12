class MealRecord < ApplicationRecord
  # アソシエーション設定
  belongs_to :diary

  # attachmentメソッド（gem:refile)使用
  attachment :meal_image

  # enum機能の定義
  enum intake_status: { その他: 0, 朝食: 1, 昼食: 2, 夕食: 3, 間食: 4 }

end
