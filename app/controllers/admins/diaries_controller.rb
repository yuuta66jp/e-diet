class Admins::DiariesController < ApplicationController
  # adminログイン時にのみアクセスを許可する(deviseのメッソド)
  before_action :authenticate_admin!

  def index
    @diaries = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
    # @diaryに紐づいたmeal_recordsを取得
    @meal_records = @diary.meal_records
    @comments = @diary.diary_comments
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to admins_diaries_path
  end

end
