class DiaryComment < ApplicationRecord
  # アソシエーション設定
  belongs_to :user
  belongs_to :diary

  # バリデーション設定
  validates :content,　presence: true

end
