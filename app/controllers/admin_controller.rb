class AdminController < ApplicationController
  def login
  	if admin?
  		flash[:error] = "You are already logged in as admin."
  		redirect_to admin_users_path
		end
  	if request.post?
			@username = params[:username]
			@password = params[:password]
			if @username == ADMIN_AUTHENTICATION_CONFIG[:username] && @password == ADMIN_AUTHENTICATION_CONFIG[:password]
				session[:admin] = "admin"
				flash[:notice] = t('notice.logged_in',:object=>t(:admin).downcase)
				redirect_to admin_users_path
			else
				flash.now[:error] = "Invalid username or password."
			end
		end
  end

  def logout
  	session[:admin] = nil
  	flash[:notice] = t('notice.logged_out',:object=>t(:admin).downcase)
  	redirect_to admin_login_path
  end

end
