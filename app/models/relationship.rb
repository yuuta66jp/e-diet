class Relationship < ApplicationRecord
  # アソシエーション設定
  # class_nameを使用し関連名からモデル名を推定できない場合、参照先(モデル名)を指定する
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
