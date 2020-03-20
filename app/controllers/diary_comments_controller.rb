class DiaryCommentsController < ApplicationController
  # ログイン済みユーザーにのみアクセスを許可する(deviseのメソッド)
  before_action :authenticate_user!

  def create
    user = current_user
    @diary = Diary.find(params[:diary_id])
    @comment = @diary.diary_comments.build(diary_comment_params)
    @comment.user_id = user.id
    if @comment.save
       # コメントポイント付与
       Reward.give_point(user,3)
       # ランクステータ変更確認(ポイント取得後)
       user.change_rank(user.rewards.total_point)
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
    # コメントポイント削除
    comment_point = user.rewards.find_by(issue_reason: 3)
    comment_point.destroy
    # ランクステータ変更確認(ポイント変更後)
    user.change_rank(user.rewards.total_point)
    render :index
  end

  private

  def diary_comment_params
    params.require(:diary_comment).permit(:content)
  end

end
