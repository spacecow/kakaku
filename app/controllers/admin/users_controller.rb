class Admin::UsersController < ApplicationController
	before_filter :verify_admin
  load_and_authorize_resource
  
  def index
  	@users = User.all
  end

  #def edit
  #	@questions = User::QUESTIONS.map{|e| t(e)}.zip( User::QUESTIONS )
  #end

	#def update
	#	if @user.update_attributes( params[:user] )
	#		flash[:notice] = t('notice.updated', :object=>t(:user).downcase)
	#		redirect_to admin_users_path
	#	else
	#		@questions = User::QUESTIONS.map{|e| t(e)}.zip( User::QUESTIONS )
	#		render :action => :edit
	#	end
	#end
	
	def destroy
		@user.destroy
		flash[:notice] = t('notice.deleted', :object=>t(:user).downcase)
		redirect_to admin_users_path
	end
	
	def confirm_delete
		destroy if request.delete? 
	end

private

	def verify_admin
		unless admin?
			flash[:error] = t('error.access_denied')
	  	redirect_to root_url 
	  end
	end
end
