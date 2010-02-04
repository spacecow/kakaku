class SessionsController < ApplicationController
  def new
  	if logged_in?
  		flash[:error] = t('error.logged_in')
  		redirect_to root_url
		end
  end
  
  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = t('notice.logged_in')
      redirect_to_target_or_default(root_url)
    else
      flash.now[:error] = t('error.invalid_login')
      render :action => 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = t('notice.logged_out')
    redirect_to root_url
  end
end
