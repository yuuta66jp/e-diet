class Topic < ApplicationRecord
  # アソシエーション設定
  belongs_to :genre

  # バリデーション設定
  validates :title, presence: true, length: { maximum: 30 }
  validates :body,  presence: true

  # attachmentメソッド（gem:refile)使用
  attachment :topic_image

end
