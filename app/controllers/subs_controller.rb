class SubsController < ApplicationController
  before_action :ensure_moderator, only: [:edit, :destroy, :update]
  before_action :require_logged_in, only: [:new, :create]

  def new
    @sub =  Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:error] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = current_sub
    render :edit
  end

  def update
    @sub = current_sub
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:error] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    render :index
  end

  def show
    @sub = current_sub
    render :show
  end

  def destroy
    current_sub.destroy
    redirect_to subs_url
  end

  def current_sub
    Sub.find_by_id(params[:id])
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def ensure_moderator
    unless current_user == current_sub.moderator
      flash[:error] = ["You must be the moderator to do that!"]
      redirect_to sub_url(current_sub)
    end
  end
end
