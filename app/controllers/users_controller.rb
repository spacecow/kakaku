class UsersController < ApplicationController
  before_filter :find_page_by_id_or_username, :only => :show
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

private

  def find_page_by_id_or_username
    @user = params[:id].to_i == 0 ? User.find_by_username( params[:id] ) : User.find( params[:id])
  end  
end
