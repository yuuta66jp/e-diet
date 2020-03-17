class Genre < ApplicationRecord
  # アソシエーション設定
  has_many :topics

  # バリデーション設定
  # inclusionによってtrueもしくはfalseが含まれているか検証(boolean型のため)
  validates :name,      presence: true
  validates :is_active, inclusion: { in: [true, false] }

end
