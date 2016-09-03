describe VisitorsController, type: :controller do
  let!(:company) { create(:company) }

  describe 'GET #index' do
    context 'valid params' do
      before do
        session[:company_token] = company.token
        get :index
      end

      it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'should load company' do
        expect(assigns(:company)).to eq company
      end

      it 'should render index' do
        expect(response).to render_template :index
      end
    end

    context 'invalid params' do
      it 'raises RoutingError' do
        expect{ get :index }.to raise_error(ActionController::RoutingError)
      end
    end

    context 'suspended company' do
      before do
        company.active = false
        company.save
        session[:company_token] = company.token
        get :index
      end

      it 'should redirect to suspended page' do
        expect(response).to redirect_to suspended_company_path(company)
      end
    end

    context 'sms' do
      let!(:sms) { create(:sms, action: :ident, company: company) }
      let(:device) { create(:device, company: company) }

      before do
        session[:company_token] = company.token
      end

      it 'should redirect to sms auth' do
        get :index
        expect(response).to redirect_to sms_authorize_path
      end

      it 'should render :index' do
        session[:mac] = device.mac
        get :index
        expect(response).to render_template :index
      end

      it 'should render adverts templater' do
        sms.adv = true
        sms.save
        session[:mac] = device.mac
        get :index
        expect(response).to render_template 'widgets/sms/adv'
      end
    end
  end
end
