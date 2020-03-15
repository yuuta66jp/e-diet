class DiaryCommentsController < ApplicationController

  def create
    @diary = Diary.find(params[:diary_id])
    @comment = @diary.diary_comments.build(diary_comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render :index
    end
  end

  def edit
    @diary = Diary.find(params[:diary_id])
    @comment = DiaryComment.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:diary_id])
    @comment = DiaryComment.find(params[:id])
    @comment.update(diary_comment_params)
    redirect_to diary_path(@diary)
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    @comment = DiaryComment.find(params[:id])
    if @comment.destroy
      render :index
    end
  end

  private

  def diary_comment_params
    params.require(:diary_comment).permit(:user_id, :diary_id, :content)
  end

end
