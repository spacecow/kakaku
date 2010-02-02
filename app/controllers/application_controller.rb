# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
	rescue_from CanCan::AccessDenied do |exception|
	  flash[:error] = t('error.access_denied')
	  redirect_to root_path		
	end
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  layout 'themes'
end
