class SessionSerializer < BaseSerializer
  attributes :token

  attribute :user_name do |session|
    session.user.name
  end
end
