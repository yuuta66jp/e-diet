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
      redirect_to admins_genres_path, notice: '新規ジャンルが作成されました'
    else #if文でエラー時の分岐表示
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      # ジャンル一覧ページに遷移
      redirect_to admins_genres_path, notice: '更新が成功しました！'
    else #if文でエラー時の分岐表示
      render :edit
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end

end
