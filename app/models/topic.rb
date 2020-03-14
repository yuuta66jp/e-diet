class Topic < ApplicationRecord
  # アソシエーション設定
  belongs_to :genre

  # attachmentメソッド（gem:refile)使用
  attachment :topic_image

end
