class Admins::GenresController < ApplicationController
  # adminログイン時にのみアクセスを許可する(deviseのメッソド)
  before_action :authenticate_admin!
  # indexページにて新規登録
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      # ジャンル一覧ページに遷移
      redirect_to admins_genres_path
    else
      flash[:alert] = '入力してください'
      redirect_to admins_genres_path
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      # ジャンル一覧ページに遷移
      redirect_to admins_genres_path
    #if文でエラー時の分岐
    else
      flash[:alert] = '入力してください'
      redirect_to edit_admins_genre_path(@genre)
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end

end
