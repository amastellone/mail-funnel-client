class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  # TODO Security - Enable forgery protection in controller that was temp. disabled for AJAX Calls
  protect_from_forgery with: :exception


  def isInstalled
    if session[:shopify].site != nil

      siteName = session[:shopify].site

      clientApp = App.where(name: siteName).first

      if clientApp.any?

      end

    else
      return false
    end
  end

  def installMailfunnelClient

  end

end
