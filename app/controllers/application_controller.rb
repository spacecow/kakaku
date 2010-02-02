# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
	rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  helper :all # include all helpers, all the time
  helper_method :admin?
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  layout 'themes'

	def admin?
		session[:admin] == "admin"
	end

	def current_user
		@user ||= User.new || User.find( session[:user_id] )
		@user.roles_mask = 1 if admin?
		@user
	end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
