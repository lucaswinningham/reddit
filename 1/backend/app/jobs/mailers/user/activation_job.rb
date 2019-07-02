module Mailers
  module User
    class ActivationJob
      include Job

      def initialize(user)
        @user = user
      end

      def deliver
        enqueue queue: queue, payload: payload
      end

      private

      attr_reader :user

      def queue
        'mailers.user.activation'
      end

      def payload
        { email: user.email, activation_link: activation_link }
      end

      def activation_link
        "#{ENV['CLIENT_URL']}/u/#{user.name}/activate/#{user.activation.token}"
      end
    end
  end
end
