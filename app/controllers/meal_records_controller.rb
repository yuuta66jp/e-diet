class MealRecordsController < ApplicationController
  # ログイン済みユーザーにのみアクセスを許可する(deviseのメソッド)
  before_action :authenticate_user!

  def new
    @meal_record = MealRecord.new
    @diary = Diary.find(params[:id])

  end

  def create
    @meal_record = MealRecord.new(meal_record_params)
    # diary_idの取得
    @diary = Diary.find(params[:meal_record][:diary_id])
    if @meal_record.save
      # createで日記編集画面へ遷移
      redirect_to edit_diary_path(@diary), notice: '食事記録が追加されました！'
    else #if文でエラー時の分岐表示
      render :new
    end
  end

  def edit
    @meal_record =MealRecord.find(params[:id])
  end

  def update
    @meal_record =MealRecord.find(params[:id])
    if @meal_record.update(meal_record_params)
      # updateで日記編集画面へ遷移
      redirect_to edit_diary_path(@meal_record.diary_id), notice: '更新が成功しました！'
    else #if文でエラー時の分岐表示
      render :edit
    end
  end

  def destroy
    @meal_record =MealRecord.find(params[:id])
    @meal_record.destroy
    # destroyで日記編集画面へ遷移
    redirect_to edit_diary_path(@meal_record.diary_id)
  end

  private
  def meal_record_params
    params.require(:meal_record).permit(:diary_id, :title, :body, :meal_image, :intake_status)
  end

end
