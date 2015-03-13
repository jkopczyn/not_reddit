class SessionsController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]
  before_action :require_logged_in, only: :destroy

  def new
    @user = User.new
    render :new
  end

  def create
    credentials = [params[:user][:username], params[:user][:password]]
    @user = User.find_by_credentials(*credentials)
    if @user.nil?
      flash.now[:error]= ["Not a valid Username/Password combination"]
      @user = User.new(username: params[:user][:username])
      render :new
    else
      login!(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
