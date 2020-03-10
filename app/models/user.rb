class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # attachmentメソッド（gem:refile)使用
  attachment :profile_image

  # アソシエーション設定
  has_many :diaries,      dependent: :destroy
  has_many :body_weights, dependent: :destroy

  # enum機能の定義
  enum gender:        { 男性: 0, 女性: 1, その他: 2 }
  enum public_status: { 公開: 0, 非公開: 1 }
  enum rank_status:   { グリーン: 0, シルバー: 1, ゴールド: 2 }

  # バリデーション設定
  validates :name,   presence: true, length: { maximum: 15 }
  validates :gender, presence: true

end
