class PointsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @point_genre = PointsGenre.new
  end

  def create
    @point_genre = PointsGenre.new(point_params)
    if @point_genre.valid?
      @point_genre.save
      redirect_to new_shop_path
    else
      render 'new'
    end
  end

  def search
    return nil if params[:keyword] == ''

    genre = Genre.where(['genre_name LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: genre }
  end

  private

  def point_params
    params.require(:points_genre).permit(:genre_name, :point1, :point2, :point3, :explanation).merge(user_id: current_user.id)
  end
end
