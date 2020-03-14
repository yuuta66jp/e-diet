class Admins::GenresController < ApplicationController

  # indexページにて新規登録
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    # ジャンル一覧ページに遷移
    redirect_to admins_genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    # ジャンル一覧ページに遷移
    redirect_to admins_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end

end
