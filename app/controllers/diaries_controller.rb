class DiariesController < ApplicationController

  def new
    @diary = Diary.new
  end

  def create
    # build=モデルオブジェクトを生成(newの別名)
    @diary = current_user.diaries.build(diary_params)
    @diary.save
    redirect_to diary_path(@diary.id)
  end

  def index
    @diaries = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def diary_params
    params.require(:diary).permit(:user_id, :remark, :activity_status)
  end

end
