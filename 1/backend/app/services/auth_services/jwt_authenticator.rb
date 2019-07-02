module AuthServices
  class JwtAuthenticator
    attr_reader :authorization_header, :claims

    def initialize(headers:)
      @authorization_header = headers['Authorization']

      return unless authorization_header

      strategy, token = authorization_header.split(' ')
      return unless strategy && strategy.casecmp('bearer').zero?

      @claims = JwtService.decode token: token
    end

    def invalid_token?
      authorization_header.nil? || invalid_claims?
    end

    private

    def invalid_claims?
      !claims || !claims.sub || expired? || premature?
    end

    def expired?
      claims.exp && Time.now > Time.at(claims['exp'])
    end

    def premature?
      claims.nbf && Time.now < Time.at(claims['nbf'])
    end
  end
end
