class CommentsController < ApplicationController

  def create
    comment = Comment.new(content: params[:comment][:content], public: params[:comment][:public])
    comment.sender = current_user
    item = Item.find(params[:comment][:item_id])
    item.comments << comment
    redirect_to item_path(item)
  end

  def destroy
    comment = Comment.find(params[:id])
    item = Item.find(comment.commentable_id)
    comment.destroy
    redirect_to item_path(item)
  end

end
