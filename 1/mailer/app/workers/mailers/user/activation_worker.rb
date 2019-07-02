module Mailers
  module User
    class ActivationWorker
      include Worker
      from_queue 'mailers.user.activation'

      def go
        puts; puts
        puts payload
        puts; puts
      end
    end
  end
end
