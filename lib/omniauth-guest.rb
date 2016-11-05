require 'omniauth'

module OmniAuth
  module Strategies
    class Guest
      include OmniAuth::Strategy

      option :name, 'guest'

      def request_phase
        redirect '/guest/callback'
      end

      uid { Time.zone.now.to_i + rand(100) }

      info do
        {
          name: 'Guest'
        }
      end
    end
  end
end
