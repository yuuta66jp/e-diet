class UsersController < ApplicationController
  # ログイン済みユーザーにのみアクセスを許可する(deviseのメソッド)
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @users = User.page(params[:page]).reverse_order
  end

  def show
    @user = User.find(params[:id])
    # グラフ用体重データ取得(pluckによりカラムの配列を取得)(to_hメソッドにより配列をハッシュに変換)
    @weight_data = @user.diaries.joins(:body_weight).pluck('diaries.created_on', 'body_weights.weight_record').to_h
  end

  def edit
    @user =User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '更新が成功しました！'
    else #if文でエラー時の分岐表示
      render :edit
    end
  end

  def congfirm
    @user = current_user
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :gender, :birthday, :height, :goal_weight, :public_status, :email, :introduction, :profile_image)
  end

end
