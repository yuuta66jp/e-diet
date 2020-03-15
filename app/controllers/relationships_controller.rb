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
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

end
