require 'omniauth'

module OmniAuth
  module Strategies
    class Sms
      include OmniAuth::Strategy

      option :fields, [:phone, :email]

      def request_phase
        form = OmniAuth::Form.new(:title => "SMS Auth", :url => callback_path)
        options.fields.each do |field|
          form.text_field field.to_s.capitalize.gsub("_", " "), field.to_s
        end
        form.button "Sign In"
        form.to_response
      end

      def callback_phase
        @form = ::Sms.new
        @form.phone = request.params['auth']['phone']

        @form.validate

        p @form.errors
        # redirect request_path + '?state=confirm'
      end
    end
  end
end
