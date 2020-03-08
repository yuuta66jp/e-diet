class BodyWeight < ApplicationRecord
  # アソシエーション設定
  belongs_to :user
  belongs_to :diary

end
