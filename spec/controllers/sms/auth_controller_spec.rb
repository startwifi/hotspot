require 'rails_helper'

RSpec.describe Sms::AuthController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #send_sms" do
    it "returns http success" do
      get :send_sms
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #validate" do
    it "returns http success" do
      get :validate
      expect(response).to have_http_status(:success)
    end
  end

end
