class Reward < ApplicationRecord
  # アソシエーション設定
  belongs_to :user

  # バリデーション設定
  # numericalityは属性に数値のみが使われているか検証(デフォルトでnillは弾く)
  # only_integerで整数のみを許可
  validates :point,        numericality: { only_integer: true }
  validates :issue_reason, presence: true

  # enum機能の定義
  enum issue_reason: { 新規登録: 0, ログイン: 1, 日記投稿:2, コメント: 3, フォロー: 4, 目標達成:5 }

  # 取得ポイントの合計値を計算
  def self.total_point
    self.all.sum(:point)
  end
  # 新規登録ポイント定義
  def self.sign_up_point(user)
    sign_up_point = Reward.new(
      user_id:      user.id,
      point:        50,
      issue_reason: 0
      )
    sign_up_point.save
  end
  # ログインポイント定義
  def self.sign_in_point(user)
    sign_in_point = Reward.new(
      user_id:      user.id,
      point:        5,
      issue_reason: 1
      )
    sign_in_point.save
  end
  # 日記作成ポイント定義
  def self.diary_point(user)
    diary_point = Reward.new(
      user_id:      user.id,
      point:        20,
      issue_reason: 2
      )
    diary_point.save
  end
  # コメントポイント定義
  def self.comment_point(user)
    comment_point = Reward.new(
      user_id:      user.id,
      point:        5,
      issue_reason: 3
      )
    comment_point.save
  end
  # フォローポイント定義
  def self.follow_point(user)
    follow_point = Reward.new(
      user_id:      user.id,
      point:        20,
      issue_reason: 4
      )
    follow_point.save
  end
  # 目標体重達成ポイント定義
  def self.achieve_point(user)
    achieve_point = Reward.new(
      user_id:      user.id,
      point:        100,
      issue_reason: 5
      )
    achieve_point.save
  end

end
