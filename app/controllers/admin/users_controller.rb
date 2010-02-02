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
			flash[:notice] = "Updated user successfully."
			redirect_to admin_users_path
		else
			render :action => :edit
		end
	end
	
	def destroy
		@user = User.find( params[:id] )
		@user.destroy
		flash[:notice] = "Deleted user successfully."
		redirect_to admin_users_path
	end
end
