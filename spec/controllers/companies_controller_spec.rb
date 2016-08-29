describe CompaniesController, type: :controller do
  sign_in_admin(true)

  describe 'GET #index' do
    let!(:companies) { create_list(:company, 2) }

    before { get :index }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'fills an array of companies' do
      expect(assigns(:companies)).to match_array(companies)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let!(:companies) { create_list(:company, 2) }
    let(:company) { companies.first }
    let!(:admins) { create_list(:admin, 2, company: company) }

    before { get :show, id: company }

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'returns a company' do
      expect(assigns(:company)).to eq company
    end

    it 'fills an array of company admins' do
      expect(assigns(:admins)).to match_array(admins)
    end

    it 'fills an array of company events' do
      expect(assigns(:recent_events)).to eq company.events
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let!(:company) { attributes_for(:company) }

      it 'creates a company' do
        expect { post :create, company: company }
          .to change(Company, :count).by(1)
      end

      it 'redirects to all companies' do
        post :create, company: company
        expect(response).to redirect_to companies_path
      end

      it 'assigns a notice' do
        post :create, company: company
        expect(flash.notice).not_to be_nil
      end
    end

    context 'with invalid attributes' do
      let!(:company) { attributes_for(:company, name: nil) }

      it 'does not create a company' do
        expect { post :create, company: company }
          .not_to change(Company, :count)
      end

      it 'renders a company form' do
        post :create, company: company
        expect(response).to render_template :new
      end
    end
  end
end
