require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:company) { create(:company) }
  let(:auth_link) { 'http://router/auth' }

  before do
    session[:company_token] = company.token
    session[:auth_link] = "http://router/auth"
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

      it 'redirects to the auth link' do
        post :create, provider: :facebook
        expect(response).to redirect_to auth_link
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
        expect(response).to redirect_to auth_link
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

    it 'redirects to the auth link' do
      delete :destroy
      expect(response).to redirect_to auth_path
    end
  end

end
