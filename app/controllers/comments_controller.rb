class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    comment = Comment.create(comment_params)
    redirect_to shop_path(comment.shop.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, shop_id: params[:shop_id])
  end
end
