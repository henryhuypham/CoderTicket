class SessionsController < ApplicationController
  before_action :skip_if_logged_in, only: [:login, :sign_up]

  def login
    unless request.post? && login_param
      return
    end

    unless (@user = User.find_by(email: params[:user][:email]))
      flash[:error] = 'Error: username or password not found!'
      return redirect_to :back
    end

    unless @user.authenticate(params[:user][:password])
      flash[:error] = "Error: #{@user.errors.full_messages.to_sentence}"
      return redirect_to :back
    end

    session[:user_id] = @user.id
    redirect_to root_path
  end

  def sign_up
    unless request.post?
      return
    end

    @user = User.new sign_up_param

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "Error: #{@user.errors.full_messages.to_sentence}"
      redirect_to :back
    end
  end

  def sign_out
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def login_param
    params.require(:user).permit(:email, :password)
  end

  def sign_up_param
    params.require(:user).permit(:name, :email, :password)
  end
end
