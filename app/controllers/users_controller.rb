class UsersController < ApplicationController
  # ログイン済みユーザーにのみアクセスを許可する(deviseのメソッド)
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user,       only: [:edit, :update]
  before_action :forbid_test_user,   only: [:update, :destroy]

  def index
    #@users = User.all
    @users = User.page(params[:page]).reverse_order
  end

  def show
    @user = User.find(params[:id])
    # グラフ用体重データ取得(pluckによりカラムの配列を取得)(to_hメソッドにより配列をハッシュに変換)
    @user_data = @user.diaries.joins(:body_weight).order('diaries.created_on').pluck('diaries.created_on', 'body_weights.weight_record').to_h
    if user_signed_in?
      @self_data = current_user.diaries.joins(:body_weight).order('diaries.created_on').pluck('diaries.created_on', 'body_weights.weight_record').to_h
    end
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
  # url直打ち防止
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path
    end
  end
  # テストユーザー用フィルター
  def forbid_test_user
    user = User.find(params[:id])
    if user.email == "test@test"
      flash[:notice] = "テストユーザーのため変更,退会はできません"
      redirect_to root_path
    end
  end

end
