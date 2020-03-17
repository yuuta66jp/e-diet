class Admins::UsersController < ApplicationController
  # adminログイン時にのみアクセスを許可する(deviseのメッソド)
  before_action :authenticate_admin!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admins_user_path(@user)
    #if文でエラー時の分岐
    else
      flash[:alert] = '入力してください'
      redirect_to edit_admins_uesr_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admins_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :gender, :birthday, :height, :goal_weight, :public_status, :email, :introduction, :profile_image)
  end

end
