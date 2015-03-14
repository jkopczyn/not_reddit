class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      #redirect?
    else
      flash.now[:error] = @comment.errors.full_messages
    end
  end
end
