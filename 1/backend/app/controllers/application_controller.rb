class ApplicationController < ActionController::API
  Rack::Utils::SYMBOL_TO_STATUS_CODE.keys.each do |status|
    define_method "render_#{status}" do |json|
      render json: json, status: status
    end
  end

  def authenticate_user!
    render_unauthorized error: 'Unauthorized' unless current_user
  end

  def current_user
    @current_user ||= begin
      jwt_authenticator = AuthServices::JwtAuthenticator.new headers: request.headers
      User.find_by_name jwt_authenticator.claims.sub unless jwt_authenticator.invalid_token?
    end
  end
end
