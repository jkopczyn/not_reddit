class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show, :index, :destroy]
  before_action :require_logged_out, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    render :show
  end

  def destroy
  end

  def index
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
