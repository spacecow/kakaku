class AdminController < ApplicationController
  def login
  	if request.post?
			@username = params[:username]
			@password = params[:password]
			if @username == ADMIN_AUTHENTICATION_CONFIG[:username] && @password == ADMIN_AUTHENTICATION_CONFIG[:password]
				session[:admin] = "admin"
				flash[:notice] = t('notice.logged_in',:object=>t(:admin).downcase)
				redirect_to admin_users_path
			else
				flash.now[:notice] = "Invalid username/password."
			end
		end
  end

  def logout
  	session[:admin] = nil
  	flash[:notice] = t('notice.logged_out',:object=>t(:admin).downcase)
  	redirect_to admin_login_path
  end

end
