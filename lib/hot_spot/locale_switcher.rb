require 'active_support/concern'

module HotSpot
  module LocaleSwitcher
    extend ActiveSupport::Concern

    included do
      before_filter :set_locale

      def set_locale
        I18n.locale = params[:locale] || I18n.default_locale
      end
    end

  end
end
