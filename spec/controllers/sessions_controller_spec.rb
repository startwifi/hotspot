require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:company) { create(:company) }

  before do
    session[:company_token] = company.token
  end

  describe 'GET #create' do
    context 'facebook' do
      before do
        request.env['omniauth.auth'] = auth_mock_facebook
      end

      it 'creates a user' do
        expect {post :create, provider: :facebook}.to change{ User.count }.by(1)
      end

      it 'creates a session' do
        expect(session[:user_id]).to be_nil
        post :create, provider: :facebook
        expect(session[:user_id]).not_to be_nil
      end

      it 'redirects to the widget' do
        post :create, provider: :facebook
        expect(response).to redirect_to widget_path
      end
    end

    context 'with vkontakte' do
      before do
        request.env['omniauth.auth'] = auth_mock_vkontakte
      end

      it 'creates a user' do
        expect {post :create, provider: :vkontakte}.to change{ User.count }.by(1)
      end

      it 'creates a session' do
        expect(session[:user_id]).to be_nil
        post :create, provider: :vkontakte
        expect(session[:user_id]).not_to be_nil
      end

      it 'redirects to the auth link' do
        post :create, provider: :vkontakte
        expect(response).to redirect_to widget_path
      end
    end
  end
end
