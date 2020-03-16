class DiariesController < ApplicationController

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
    @diary.save
    # 日記作成ポイント付与
    @diary_point = user.rewards.build(
      point:        20,
      issue_reason: 2
      )
    @diary_point.save
    # body_weight作成
    # 1対１の際、buildによる関連付けメソッド(build_関連付けメソッド名)を使用
    @body_weight = @diary.build_body_weight(
      user_id:       user.id,
      weight_record: params[:diary][:body_weight][:weight_record]
      )
    @body_weight.save
    # 目標体重達成ポイント付与
    if @body_weight.weight_record <= user.goal_weight
      @achieve_point = user.rewards.build(
      point:        100,
      issue_reason: 5
      )
      @achieve_point.save
    end
    # ランクステータ変更確認(ポイント取得後)
    user.change_rank(user.rewards.total_point)
    # createで新規食事記録画面へ遷移（パラメーターをredirect_toに直接渡す）
    redirect_to new_meal_record_path(id: @diary.id)
  end

  def index
    @diaries = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
    # @diaryに紐づいたmeal_recordsを取得
    @meal_records = @diary.meal_records
    # comment表示、作成
    @comments = @diary.diary_comments
    @comment = @diary.diary_comments.build
  end

  def edit
    @diary = Diary.find(params[:id])
    @meal_records = @diary.meal_records
    # find_byメソッドによりdairy_idより取得
    @body_weight = BodyWeight.find_by(diary_id: params[:id])
  end

  def update
    @diary = Diary.find(params[:id])
    @diary.update(diary_params)
    @body_weight = BodyWeight.find_by(diary_id: params[:id])
    @body_weight.update(
      weight_record: params[:diary][:body_weight][:weight_record]
      )
    redirect_to diary_path(@diary.id)
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diaries_path
  end

  private

  def diary_params
    params.require(:diary).permit(:user_id, :remark, :activity_status, :tag_list, :created_on)
  end

end
