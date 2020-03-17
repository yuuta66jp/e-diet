class DiaryCommentsController < ApplicationController
  # ログイン済みユーザーにのみアクセスを許可する(deviseのメソッド)
  before_action :authenticate_user!

  def create
    @diary = Diary.find(params[:diary_id])
    @comment = @diary.diary_comments.build(diary_comment_params)
    @comment.user_id = current_user.id
    if @comment.save
       # コメントポイント付与
       Reward.comment_point(current_user)
       # ランクステータ変更確認(ポイント取得後)
       current_user.change_rank(current_user.rewards.total_point)
      render :index
    #if文でエラー時の分岐
    else
      flash[:alert] = 'コメントを入力してください'
      redirect_to diary_path(@diary)
    end
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    @comment = DiaryComment.find(params[:id])
    @comment.destroy
    # コメントポイント削除
    comment_point = current_user.rewards.find_by(issue_reason: 3)
    comment_point.destroy
    # ランクステータ変更確認(ポイント変更後)
    current_user.change_rank(current_user.rewards.total_point)
    render :index
  end

  private

  def diary_comment_params
    params.require(:diary_comment).permit(:content)
  end

end
