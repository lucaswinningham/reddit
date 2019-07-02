module ControllerServices
  class ActivationsService
    attr_reader :user, :nonce, :token, :password

    def initialize(user:, params:)
      @user = user
      @nonce, @password, @token = AuthServices::CipherService.decrypt(params[:message]).split('||')
    end

    def valid_nonce?
      user.nonce && !user.nonce.expired? && user.nonce.value == nonce
    end

    def authentic_token?
      user.activation.authenticate token
    end

    def make_session
      payload = { sub: user.name }
      token = AuthServices::JwtService.encode(payload: payload)
      OpenStruct.new id: nil, user: user, token: token
    end
  end
end
