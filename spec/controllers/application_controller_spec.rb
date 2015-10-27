require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render text: "This is anonymous controller"
    end
  end

  describe 'Base' do
    it 'should change locale by ?locale=uk param' do
      get :index, locale: 'uk'

      expect(I18n.locale).to eq :uk
    end
  end
end
