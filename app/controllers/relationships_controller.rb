class RelationshipsController < ApplicationController
  # ログイン済みユーザーにのみアクセスを許可する(deviseのメソッド)
  before_action :authenticate_user!, except: [:index]

  def index
    user = User.find(params[:user_id])
    case params[:index]
      when "follower"
    @users = user.following_user.page(params[:page]).reverse_order
      when "followed"
    @users = user.follower_user.page(params[:page]).reverse_order
    end
  end

  def create
    user = current_user
    user.follow(params[:user_id])
    # フォローポイント付与
    Reward.give_point(user,4)
    # ランクステータ変更確認(ポイント取得後)
    user.change_rank(user.rewards.total_point)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = current_user
    user.unfollow(params[:user_id])
    # フォロー解除時にポイント削除
    follow_point = user.rewards.find_by(issue_reason: 4)
    follow_point.destroy
    # ランクステータ変更確認(ポイント変更後)
    user.change_rank(user.rewards.total_point)
    redirect_back(fallback_location: root_path)
  end

end
