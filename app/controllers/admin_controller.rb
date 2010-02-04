class AdminController < ApplicationController
  def login
  	if admin?
  		flash[:error] = t('error.admin_logged_in')
  		redirect_to admin_users_path
		end
  	if request.post?
			@username = params[:username]
			@password = params[:password]
			if @username == ADMIN_AUTHENTICATION_CONFIG[:username] && @password == ADMIN_AUTHENTICATION_CONFIG[:password]
				session[:admin] = "admin"
				flash[:notice] = t('notice.logged_in_as',:object=>t(:admin).downcase)
				redirect_to admin_users_path
			else
				flash.now[:error] = t('error.invalid_username')
			end
		end
  end

  def logout
  	session[:admin] = nil
  	flash[:notice] = t('notice.logged_out_as',:object=>t(:admin).downcase)
  	redirect_to admin_login_path
  end

end
