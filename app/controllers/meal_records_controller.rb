class MealRecordsController < ApplicationController

  def new
    @meal_record = MealRecord.new
    @diary = Diary.find(params[:id])


  end

  def create

    @meal_record = MealRecord.new(meal_record_params)

    @meal_record.save

    # diary_idの取得
    @diary_id = params[:meal_record][:diary_id]
    redirect_to edit_diary_path(id: @diary_id)
  end

  def edit
    @meal_record =MealRecord.find(params[:id])
  end

  def update
    @meal_record =MealRecord.find(params[:id])
    @meal_record.update(meal_record_params)

    redirect_to edit_diary_path(@meal_record.diary_id)
  end

  private
  def meal_record_params
    params.require(:meal_record).permit(:diary_id, :title, :body, :meal_image, :intake_status)
  end

end

