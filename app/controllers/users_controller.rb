class UsersController < ApplicationController
  load_and_authorize_resource
  
  def new
  end
  
  def create
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
