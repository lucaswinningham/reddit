module Helpers
  module Authenticatable
    def login(user)
      payload = { sub: user.name }
      token = AuthServices::JwtService.encode(payload: payload)
      @request.headers['Authorization'] = "Bearer #{token}"
      user
    end
  end
end
