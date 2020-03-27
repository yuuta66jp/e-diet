class TopicsController < ApplicationController

  def index
    @topics = Topic.page(params[:page]).reverse_order.per(6)
  end

  def show
    @topic = Topic.find(params[:id])
  end

end
