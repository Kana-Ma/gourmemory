class ShopsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def new
    @genre_ids = UserGenreRelation.where(user_id: current_user.id).pluck(:genre_id)
    @shop = Shop.new
  end

  def search
    point = Point.where(genre_id: params[:genre_id], user_id: current_user.id)
    render json: { point: point }
  end

  def create
    @genre_ids = UserGenreRelation.where(user_id: current_user.id).pluck(:genre_id)
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to root_path
    else
      redirect_to action: :new
    end
  end

  private

  def shop_params
    params.require(:shop).permit(
      :shop_name, :address, :total_rate, :rate1, :rate2, :rate3, :text, :image, :point_id, :genre_id
    ).merge(user_id: current_user.id)
  end
end
