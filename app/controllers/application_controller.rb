# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  layout 'default'
  before_filter :adjust_format_for_puppet
  before_filter :require_user


  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user


  protected

  def adjust_format_for_puppet
    request.format = :puppet if puppet_request?
  end

  def puppet_request?
    request.request_uri =~ /.pp$/
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    realm = "ThreatMetrix Asset Tracker"
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"

      respond_to do |wants|
        wants.html { redirect_to new_user_session_url }
        wants.all { request_http_basic_authentication(realm) }
      end

      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
