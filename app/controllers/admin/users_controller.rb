class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  
  def index
  	@users = User.all
  end

  def edit
  	@user = User.find( params[:id] )
  end

	def update
		@user = User.find( params[:id] )
		if @user.update_attributes( params[:user] )
			flash[:notice] = t('notice.updated', :object=>t(:user))
			redirect_to admin_users_path
		else
			render :action => :edit
		end
	end
	
	def destroy
		@user = User.find( params[:id] )
		@user.destroy
		flash[:notice] = t('notice.deleted', :object=>t(:user))
		redirect_to admin_users_path
	end
	
	def confirm_delete
		destroy if request.delete? 
	end
end
