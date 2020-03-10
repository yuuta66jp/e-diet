class DiariesController < ApplicationController

  def new
    # viewへ渡すためのインスタンス変数に空のモデルオブジェクトを作成
    @diary = Diary.new
    @body_weight = BodyWeight.new
  end

  def create
    # build=モデルオブジェクトを生成(newの別名)
    @diary = current_user.diaries.build(diary_params)
    @diary.save

    # body_weight作成
    @body_weight = @diary.build_body_weight(
      user_id: current_user.id,
      weight_record: params[:diary][:body_weight][:weight_record]
      )
    @body_weight.save

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
    # destroyで日記一覧画面へ遷移
    redirect_to diaries_path
  end

  private
  def diary_params
    params.require(:diary).permit(:user_id, :remark, :activity_status)
  end

end
