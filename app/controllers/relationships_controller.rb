class RelationshipsController < ApplicationController

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
    @follow_point = current_user.rewards.build(
    point:        20,
    issue_reason: 4
    )
    @follow_point.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:user_id])
    # フォロー解除時にポイント削除
    point = current_user.rewards.find_by(issue_reason: 4)
    point.destroy
    redirect_back(fallback_location: root_path)
  end

end
