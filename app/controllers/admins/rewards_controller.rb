class Admins::RewardsController < ApplicationController

  def index
    # case文にて全件もしくは該当userの表示を分岐
    case params[:index]
      when "all"
        @rewards = Reward.all
      when "user"
        @user = User.find(params[:id])
        @rewards = @user.rewards
    end
  end

end
