class Admins::TopicsController < ApplicationController
  # adminログイン時にのみアクセスを許可する(deviseのメッソド)
  before_action :authenticate_admin!
  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_prams)
    if @topic.save
      redirect_to admins_topic_path(@topic)
    #if文でエラー時の分岐
    else
      flash[:alert] = '入力してください'
      redirect_to new_admins_topic_path
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
      redirect_to admins_topic_path(@topic)
    #if文でエラー時の分岐
    else
      flash[:alert] = '入力してください'
      redirect_to edit_admins_topic_paht(@topic)
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
