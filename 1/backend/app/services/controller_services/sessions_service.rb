module ControllerServices
  class SessionsService
    attr_reader :user, :nonce, :password

    def initialize(user:, params:)
      @user = user
      @nonce, @password = AuthServices::CipherService.decrypt(params[:message]).split('||')
    end

    def valid_nonce?
      user.nonce && !user.nonce.expired? && user.nonce.value == nonce
    end

    def valid_password?
      user.authenticate password
    end

    def make_session
      payload = { sub: user.name }
      token = AuthServices::JwtService.encode(payload: payload)
      OpenStruct.new id: nil, user: user, token: token
    end
  end
end
