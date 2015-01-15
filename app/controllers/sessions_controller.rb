class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password])

    if @user
      session[:user_id] = @user.id
      redirect_to chickens_path, :success => "You have just logged in"
    else
      flash[:error] = "Credentials invalid."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "User logged out"
    redirect_to login_path
  end

end