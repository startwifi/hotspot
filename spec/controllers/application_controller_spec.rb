describe ApplicationController, type: :controller do
  controller do
    def index
      render text: "This is anonymous controller"
    end
  end

  describe 'Base' do
    it 'should change locale by ?locale=en param' do
      get :index, locale: 'en'

      expect(I18n.locale).to eq :en
    end
  end
end
