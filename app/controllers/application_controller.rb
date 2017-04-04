class ApplicationController < ActionController::Base
  before_action :install_server_app
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  # TODO Security - Enable forgery protection in controller that was temp. disabled for AJAX Calls
  protect_from_forgery with: :exception


  def activate_session
    ShopifyAPI::Base.activate_session(session)
  end

  def install_server_app

    begin
      domain = ShopifyAPI::Shop.current.domain

      if domain != nil
        server_app = App.where(name: domain)

        if server_app.any? == false
          digest = OpenSSL::Digest.new('sha256')
          token = Base64.encode64(OpenSSL::HMAC.digest(digest, ENV['SECRET_KEY_BASE'], domain)).strip
          server_app = App.create(name: domain, auth_token: token)
        end

      end
    end
  rescue => e
    logger.error e.message
  end

end
