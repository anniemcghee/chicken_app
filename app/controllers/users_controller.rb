class UsersController < ApplicationController

  def create
    @user = User.create(params.require(:user).permit(:name, :email, :password, :password_confirmation))
      if @user
        session[:user_id] = @user.id
        redirect_to chickens_path, :success => "You have just logged in"

        else
        render 'new'
      end
  end

  def show
    @user = current_user
    @flock = @user.flocks.all
  end

end