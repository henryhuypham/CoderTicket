class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def required_login
    unless logged_in?
      flash[:error] = 'You must sign in to see this page!'
      redirect_to root_path
    end
  end

  def skip_if_logged_in
    redirect_to root_path if logged_in?
  end
end
