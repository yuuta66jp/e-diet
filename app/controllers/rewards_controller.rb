class RewardsController < ApplicationController
  # ログイン済みユーザーにのみアクセスを許可する(deviseのメソッド)
  before_action :authenticate_user!

  def index
    @user = current_user
    @rewards = @user.rewards
  end

end
