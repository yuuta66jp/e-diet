class BodyWeight < ApplicationRecord
  # アソシエーション設定
  belongs_to :user
  belongs_to :diary

  # バリデーション設定
  # numericalityは属性に数値のみが使われているか検証(デフォルトでnillは弾く)
  validates :weight_record, numericality: true

end
