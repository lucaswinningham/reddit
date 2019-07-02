module AuthServices
  class JwtService
    def self.encode(payload:)
      now = Time.now.to_i
      payload[:iat] = now
      payload[:nbf] = now
      payload[:exp] = 2.hours.from_now.to_i
      JWT.encode(payload, secret)
    end

    def self.decode(token:)
      OpenStruct.new JWT.decode(token, secret).first
    rescue JWT::DecodeError
      nil
    end

    def self.secret
      ENV['JWT_KEY']
    end
  end
end
