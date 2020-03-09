class MealRecordsController < ApplicationController

  def new
    @meal_record = MealRecord.new

    #binding.pry
  end

  def create
    @meal_record = MealRecord.new(meal_record_params)
    @diary = current_user.diaries.build
    @diary.save
    @meal_record[:diary_id] = @diary.id
    @meal_record.save
    redirect_to new_diary_path
  end

  private
  def meal_record_params
    params.require(:meal_record).permit(:diary_id, :title, :body, :meal_image, :intake_status)
  end

end

