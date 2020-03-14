class Admins::TopicsController < ApplicationController

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_prams)
    @topic.save
    redirect_to admins_topic_path(@topic.id)
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
    @topic.update(topic_prams)
    redirect_to admins_topic_path(@topic.id)
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
