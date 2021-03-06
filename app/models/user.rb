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

  # バリデーション設定
  validates :name,        presence: true, length: { maximum: 15 }
  validates :gender,      presence: true
  validates :birthday,    presence: true
  validates :goal_weight, numericality: { only_integer: true }
  # 空欄を許可
  validates :height,          numericality: { only_integer: true }, allow_blank: true
  validates :total_point,     numericality: { only_integer: true }
  validates :introduction,    length: { maximum: 50 }
  validates :mail_permission, inclusion: { in: [true, false] }


  # enum機能の定義
  enum gender:        { 男性: 0, 女性: 1, その他: 2 }
  enum public_status: { 公開: 0, 非公開: 1 }
  enum rank_status:   { グリーン: 0, シルバー: 1, ゴールド: 2 }

  # 現在の体重取得
  def latest_diary
    diaries.order(created_on: :desc).first
  end
  # ぼっち演算子でnilガード
  def latest_weight_record
    latest_diary&.body_weight&.weight_record
  end

  # ランクステータス変更メソッド
  def change_rank(point)
    # ゴールドランク変更(200point以上)
    if point >= 200
      update(rank_status: 2)
    # シルバーランク変更(100point以上)
    elsif point >= 100
      update(rank_status: 1)
    else
    # グリーンランク(初期ランク)
      update(rank_status: 0)
    end
  end

  #自分がフォローしている人
  # フォローする側のUser(="follower_id")からみてフォローされるUserを中間テーブル(follower)を介して集める
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  # 中間テーブル(follower)を通して(through)、followedモデル(source)のUser(フォローされた側)を集めることをfollowing_userと定義する
  has_many :following_user, through: :follower, source: :followed

  #自分をフォローしている人
  # フォローされる側のUser(="followed_id")からみてフォローしてくるUserを中間テーブル(followed)を介して集める
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  # 中間テーブル(followed)を通して(through)、followerモデル(source)のUser(フォローする側)を集めることをfollower_userと定義する
  has_many :follower_user,  through: :followed, source: :follower

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
