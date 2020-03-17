class RelationshipsController < ApplicationController
  # ログイン済みユーザーにのみアクセスを許可する(deviseのメソッド)
  before_action :authenticate_user!, except: [:index]

  def index
    user = User.find(params[:user_id])
    case params[:index]
      when "follower"
    @users = user.following_user
      when "followed"
    @users = user.follower_user
    end
  end

  def create
    current_user.follow(params[:user_id])
    # フォローポイント付与
    Reward.follow_point(current_user)
    # ランクステータ変更確認(ポイント取得後)
    current_user.change_rank(current_user.rewards.total_point)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:user_id])
    # フォロー解除時にポイント削除
    follow_point = current_user.rewards.find_by(issue_reason: 4)
    follow_point.destroy
    # ランクステータ変更確認(ポイント変更後)
    current_user.change_rank(current_user.rewards.total_point)
    redirect_back(fallback_location: root_path)
  end

end
