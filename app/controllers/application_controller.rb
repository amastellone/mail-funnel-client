class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  # TODO Security - Enable forgery protection in controller that was temp. disabled for AJAX Calls
  protect_from_forgery with: :exception

  # around_filter timecop??
end
