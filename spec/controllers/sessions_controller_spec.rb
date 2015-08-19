require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

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

      it 'redirects to the social page' do
        post :create, provider: :facebook
        expect(response).to redirect_to social_url
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

      it 'redirects to the social page' do
        post :create, provider: :vkontakte
        expect(response).to redirect_to social_url
      end
    end
  end

  describe '#destroy' do
    before do
      request.env['omniauth.auth'] = auth_mock_facebook
      post :create, provider: :facebook
    end

    it 'resets the session' do
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the social page' do
      delete :destroy
      expect(response).to redirect_to social_url
    end
  end

end
