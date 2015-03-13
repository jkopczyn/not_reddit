class PostsController < ApplicationController
  before_action :ensure_author, only: [:edit, :update]

  def new
    @post = Post.new
    @sub = current_sub
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = current_sub.id
    if @post.save
      redirect_to sub_post_url(@post.sub, @post)
    else
      flash.now[:error] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = current_post
    render :edit
  end

  def update
    @post = current_post
    if @post.update(post_params)
      redirect_to sub_post_url(@post.sub, @post)
    else
      flash.now[:error] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = current_post
    render :show
  end

  def current_sub
    Sub.find_by_id(params[:sub_id])
  end

  def current_post
    Post.find_by_id(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def ensure_author
    unless current_user == current_post.author
      flash[:error] = ["You must be the post author to do that!"]
      redirect_to sub_post_url(current_sub, current_post)
    end
  end
end
