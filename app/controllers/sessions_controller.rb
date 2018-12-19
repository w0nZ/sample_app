class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
  #Comments
  #@user = User.find_by(email: params[:session][:email].downcase)
  #  if assigns(:user) && assigns(:user).authenticate(params[:session][:password])
  #    log_in assigns(:user)
  #    params[:session][:remember_me] == '1' ? remember(assigns(:user)) : forget(assigns(:user))
  #    redirect_to assigns(:user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
