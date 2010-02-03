class UsersController < ApplicationController
  load_and_authorize_resource
  
  def show
  end
  
  def new
  end
  
  def create
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = t('message.signup_thanks')
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
