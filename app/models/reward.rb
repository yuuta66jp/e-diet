class Reward < ApplicationRecord
  # アソシエーション設定
  belongs_to :user

  # バリデーション設定
  # numericalityは属性に数値のみが使われているか検証(デフォルトでnillは弾く)
  # only_integerで整数のみを許可
  validates :point,        numericality: { only_integer: true }
  validates :issue_reason, presence: true

  # enum機能の定義
  enum issue_reason: { 新規登録: 0, ログイン: 1, 日記投稿:2, フォロー: 3, 目標達成: 4 }
  # point(定数)の定義
  Point = [30, 5, 10, 10, 100]

  # 取得ポイントの合計値を計算
  def self.total_point
    self.all.sum(:point)
  end
  # ポイント取得メソッドの定義
    def self.give_point(user,reason)
    create(
      user_id: user.id,
      point: Point[reason],
      issue_reason: reason
      )
    user.total_point += Point[reason]
  end

end
