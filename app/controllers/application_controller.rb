# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
	rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t('error.access_denied')
    redirect_to root_url
  end
  helper :all # include all helpers, all the time
  helper_method :admin?
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  layout 'themes'

	def admin?
		session[:admin] == "admin"
	end

	def current_ability_user
		#@user ||= User.exists?( session[:user_id] ) ? User.find( session[:user_id] ) : User.new
		#@user.roles_mask = 1 if admin?
		#@user
		admin? ? "admin" : current_user
	end
	
	def current_ability
    Ability.new( current_ability_user )
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
