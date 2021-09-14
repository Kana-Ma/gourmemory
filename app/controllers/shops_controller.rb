class ShopsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :check_contributor, only: [:edit, :update, :destroy]

  def index
    @shops = Shop.order('created_at DESC')
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

  def show
  end

  def edit
  end

  def update
    if @shop.update(shop_params)
      redirect_to shop_path(@shop.id)
    else
      render action: :edit
    end
  end

  def destroy
    if @shop.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def shop_params
    params.require(:shop).permit(
      :shop_name, :address, :total_rate, :rate1, :rate2, :rate3, :text, :image, :point_id, :genre_id
    ).merge(user_id: current_user.id)
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def check_contributor
    unless @shop.user_id == current_user.id
      redirect_to root_path
    end
  end
end
