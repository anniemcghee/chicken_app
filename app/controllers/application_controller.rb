class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def not_found
    raise ActionController::RoutingError.new('Chicken Not Found')
  end

  def is_authenticated?
    redirect_to login_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
end
