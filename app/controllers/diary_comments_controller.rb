class DiaryCommentsController < ApplicationController
  # ログイン済みユーザーにのみアクセスを許可する(deviseのメソッド)
  before_action :authenticate_user!

  def create
    user = current_user
    @diary = Diary.find(params[:diary_id])
    @comment = @diary.diary_comments.build(diary_comment_params)
    @comment.user_id = user.id
    if @comment.save
      render :index
    else #if文でエラー時の分岐表示
      redirect_to diary_path(@diary), notice: 'コメントを入力してください'
    end
  end

  def destroy
    user = current_user
    @diary = Diary.find(params[:diary_id])
    @comment = DiaryComment.find(params[:id])
    @comment.destroy
    render :index
  end

  private

  def diary_comment_params
    params.require(:diary_comment).permit(:content)
  end

end
