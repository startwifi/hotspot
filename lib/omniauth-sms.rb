require 'omniauth'

module OmniAuth
  module Strategies
    class Sms
      include OmniAuth::Strategy

      option :smsauth_url, '/smsauth'

      def request_phase
        redirect options.smsauth_url
      end

      uid do
        session[options.uid_field.to_s]
      end

      info do
        { name: uid }
      end
    end
  end
end
