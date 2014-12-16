class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.save 
    redirect_to root_path
  end

  def index
    @comments = Comment.all.order('created_at DESC')
    render :layout=>false
  end

  private
  def comment_params
    params.require(:comment).permit(:text)
  end
end