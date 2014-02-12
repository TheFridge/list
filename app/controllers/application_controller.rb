class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authenticate
  TOKEN = ENV['SUPER_SECRET_TOKEN']

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      token == TOKEN
    end
  end

end
