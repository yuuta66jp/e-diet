class Admins::TopicsController < ApplicationController
  # adminログイン時にのみアクセスを許可する(deviseのメッソド)
  before_action :authenticate_admin!
  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_prams)
    if @topic.save
      redirect_to admins_topic_path(@topic), notice: 'トピックスが作成されました！'
    else #if文でエラー時の分岐表示
      render :new
    end
  end

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_prams)
      redirect_to admins_topic_path(@topic), notice: '更新が成功しました！'
    else #if文でエラー時の分岐表示
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to admins_topics_path
  end

  private

  def topic_prams
    params.require(:topic).permit(:genre_id, :title, :body, :topic_image)
  end

end
