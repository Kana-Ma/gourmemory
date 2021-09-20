class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @points = Point.where(user_id: @user.id)
    @shops = Shop.where(user_id: @user.id)
  end
end
