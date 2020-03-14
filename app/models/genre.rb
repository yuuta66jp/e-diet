class Genre < ApplicationRecord
  # アソシエーション設定
  has_many :topics

end
