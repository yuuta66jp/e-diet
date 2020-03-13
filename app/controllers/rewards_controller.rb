class RewardsController < ApplicationController

  def index
    @user = current_user
    @rewards = @user.rewards
  end

end
