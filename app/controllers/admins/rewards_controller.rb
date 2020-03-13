class Admins::RewardsController < ApplicationController

  def index
    case params[:index]
      when "all"
        @rewards = Reward.all
      when "user"
        @user = User.find(params[:id])
        @rewards = @user.rewards
    end
  end

end
