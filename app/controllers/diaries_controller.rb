class DiariesController < ApplicationController
  # ログイン済みユーザーにのみアクセスを許可する(deviseのメソッド)
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update]

  def new
    # viewへ渡すためのインスタンス変数に空のモデルオブジェクトを作成
    @diary = Diary.new
    @body_weight = BodyWeight.new
  end

  def create
    user = current_user
    # build=モデルオブジェクトを生成(newの別名)
    # 1対Nの際、buildによる関連付けメソッド(関連付けメソッド名.build)を使用
    @diary = user.diaries.build(diary_params)
    # 1対１の際、buildによる関連付けメソッド(build_関連付けメソッド名)を使用
    @body_weight = @diary.build_body_weight(
      user_id:       user.id,
      weight_record: params[:diary][:body_weight][:weight_record]
      )
    if @diary.save
      # 日記作成ポイント付与
      Reward.give_point(user,2)
      # body_weight作成
      if @body_weight.save
        # 目標体重達成ポイント付与
        if @body_weight.weight_record <= user.goal_weight
          Reward.give_point(user,4)
        end
        # ランクステータ変更確認(ポイント取得後)
        user.change_rank(user.rewards.total_point)
        # createで新規食事記録画面へ遷移（パラメーターをredirect_toに直接渡す）
        redirect_to new_meal_record_path(id: @diary.id), notice: '日記作成ポイント(10point)獲得しました！<br>引き続き食事記録を追加してください'
      else #if文でエラー時の分岐表示
        @meal_records = @diary.meal_records
        flash.now[:alert] = '体重を入力してください'
        render :edit
      end
    else #if文でエラー時の分岐表示
      render :new
    end
  end

  def index
    # 遷移元のリンクにより表示を分岐する
    if params[:index] == "user"
      @user = User.find(params[:id])
      @diaries = @user.diaries.page(params[:page]).reverse_order
    else
      @diaries = Diary.page(params[:page]).reverse_order
    end
    # タグ検索
    if params[:tag_name]
      @diaries = Diary.tagged_with("#{params[:tag_name]}").page(params[:page]).reverse_order
    end
  end

  def show
    @diary = Diary.find(params[:id])
    # @diaryに紐づいたmeal_recordsを取得
    @meal_records = @diary.meal_records.order(intake_status: :asc)
    # comment表示、作成
    @comments = @diary.diary_comments
    @comment = DiaryComment.new
  end

  def edit
    @diary = Diary.find(params[:id])
    @meal_records = @diary.meal_records.order(intake_status: :asc)
    # find_byメソッドによりdairy_idより取得
    unless @body_weight = BodyWeight.find_by(diary_id: params[:id])
      @body_weight = BodyWeight.new
    end
  end

  def update
    @diary = Diary.find(params[:id])
    @meal_records = @diary.meal_records
    unless @body_weight = BodyWeight.find_by(diary_id: params[:id])
      @body_weight = @diary.build_body_weight(
      user_id:       current_user.id,
      weight_record: params[:diary][:body_weight][:weight_record]
      )
    end
    if @diary.update(diary_params)
      if @body_weight.update(
        weight_record: params[:diary][:body_weight][:weight_record]
        )
        redirect_to diary_path(@diary.id), notice: '更新が成功しました！'
      elsif @body_weight.save
        redirect_to diary_path(@diary.id), notice: '更新が成功しました！'
      else
        flash.now[:alert] = '体重を入力してください'
        render :edit
      end
    else #if文でエラー時の分岐表示
      render :edit
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diaries_path
  end

  private
  def diary_params
    params.require(:diary).permit(:remark, :activity_status, :tag_list, :created_on)
  end
  # url直打ち防止
  def correct_user
    diary = Diary.find(params[:id])
    if current_user.id != diary.user.id
      redirect_to diary_path
    end
  end

end
