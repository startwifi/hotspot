describe AdminsController, type: :controller do
  sign_in_admin(true)

  describe 'POST #create' do
    let!(:company) { create(:company) }

    context 'with valid attributes' do
      let!(:admin) { attributes_for(:admin) }

      it 'creates an admin' do
        expect { post :create, params: { company_id: company.id, admin: admin } }
          .to change(Admin, :count).by(1)
      end

      it 'redirects to all companies' do
        post :create, params: { company_id: company.id, admin: admin }
        expect(response).to redirect_to company_path(company)
      end

      it 'assigns a notice' do
        post :create, params: { company_id: company.id, admin: admin }
        expect(flash.notice).not_to be_nil
      end
    end

    context 'with invalid attributes' do
      let(:admin) { attributes_for(:admin, email: nil) }

      it 'does not create an admin' do
        expect { post :create, params: { company_id: company.id, admin: admin } }
          .not_to change(Admin, :count)
      end

      it 'renders an admin form' do
        post :create, params: { company_id: company.id, admin: admin }
        expect(response).to render_template :new
      end

      it 'assigns a flash message' do
        post :create, params: { company_id: company.id, admin: admin }
        expect(flash.now).not_to be_nil
      end
    end
  end
end
