class SessionsController < ApplicationController
  def new
		@login       = cookies[:login]
		@password    = cookies[:password]
		@remember_me = cookies[:remember_me].blank? ? nil : cookies[:remember_me]
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
 			if params[:remember_me]
 				cookies[:login]       = { :value => params[:login], :expires => 1.year.from_now }
 				cookies[:password]    = { :value => params[:password], :expires => 1.year.from_now }
 				cookies[:remember_me] = { :value => true, :expires => 1.year.from_now }
 			else
 				cookies.delete(:login)
 				cookies.delete(:password)
 				cookies.delete(:remember_me)
 			end       
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
