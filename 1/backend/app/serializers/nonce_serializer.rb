class NonceSerializer < BaseSerializer
  attributes :value

  attribute :user_name do |nonce|
    nonce.user.name
  end
end
