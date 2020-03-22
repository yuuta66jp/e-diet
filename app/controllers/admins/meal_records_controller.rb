class Admins::MealRecordsController < ApplicationController

  def show
    @meal_record =MealRecord.find(params[:id])
  end

end
