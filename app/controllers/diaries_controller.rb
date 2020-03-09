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
