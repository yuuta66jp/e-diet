class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # attachmentメソッド（gem:refile)使用
  attachment :profile_image

  # アソシエーション設定
  has_many :diaries,        dependent: :destroy
  has_many :body_weights,   dependent: :destroy
  has_many :rewards,        dependent: :destroy
  has_many :diary_comments, dependent: :destroy
  # class_nameを使用し関連名からモデル名を推定できない場合、参照先(モデル名)を指定する
  # foreign_keyを使用し直接外部キー(カラム)を指定する
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed #自分がフォローしている人
  has_many :follower_user,  through: :followed, source: :follower #自分がフォローしている人

  # enum機能の定義
  enum gender:        { 男性: 0, 女性: 1, その他: 2 }
  enum public_status: { 公開: 0, 非公開: 1 }
  enum rank_status:   { グリーン: 0, シルバー: 1, ゴールド: 2 }

  # バリデーション設定
  validates :name,   presence: true, length: { maximum: 15 }
  validates :gender, presence: true

  # フォローする・フォロー外す・フォローしているか確認を行うメソッドの定義
  # フォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  # フォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  # フォローしているか確認(フォローしてればtrueを返す)
  def following?(user)
  following_user.include?(user)
  end

end
