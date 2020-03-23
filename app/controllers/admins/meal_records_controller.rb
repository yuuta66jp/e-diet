class Admins::MealRecordsController < ApplicationController
  # adminログイン時にのみアクセスを許可する(deviseのメッソド)
  before_action :authenticate_admin!

  def show
    @meal_record =MealRecord.find(params[:id])
  end

end
