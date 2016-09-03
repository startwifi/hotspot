describe SessionsController, type: :controller do
  let!(:company) { create(:company) }

  before do
    session[:company_token] = company.token
  end

  describe 'GET #create' do
    context 'facebook' do
      let!(:auth) { auth_mock_facebook }

      before do
        request.env['omniauth.auth'] = auth
      end

      it 'creates a user' do
        expect { post :create, provider: :facebook }.to change{ User.count }.by(1)
      end

      it 'creates an event' do
        expect { post :create, provider: :facebook }.to change{ Event.count }.by(1)
      end

      it 'creates a device' do
        expect { post :create, provider: :facebook }.to change{ Device.count }.by(1)
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

      it 'saves user token' do
        post :create, provider: :facebook
        expect(session[:user_token]).to eq auth.credentials.token
      end

      context 'saves for new user' do
        before do
          post :create, provider: :facebook
          @user = User.first
        end

        it 'name' do
          expect(@user.name).to eq 'Bender Rodriguez'
        end

        it 'provider' do
          expect(@user.provider).to eq 'facebook'
        end

        it 'uid' do
          expect(@user.uid).to eq '001100010010011110100001101101110011'
        end

        it 'valid birthday' do
          expect(@user.birthday.to_s).to eq '2123-12-10'
        end

        it 'url' do
          expect(@user.url).to eq 'https://www.facebook.com/app_scoped_user_id/001100010010011110100001101101110011'
        end

        it 'gender' do
          expect(@user.gender).to be_nil
        end
      end

      context 'updates for existing user' do
        before do
          post :create, provider: :facebook
          @user = User.first
          auth.info.name = 'Redneb Zeugirdor'
          auth.extra.raw_info.birthday = '03/30/2030'
          auth.info.urls.Facebook = 'https://facebook.com/bender'
          request.env['omniauth.auth'] = auth
          post :create, provider: :facebook
          @user.reload
        end

        it 'name' do
          expect(@user.name).to eq 'Redneb Zeugirdor'
        end

        it 'valid birthday' do
          expect(@user.birthday.to_s).to eq '2030-03-30'
        end

        it 'url' do
          expect(@user.url).to eq 'https://facebook.com/bender'
        end
      end
    end

    context 'vkontakte' do
      let!(:auth) { auth_mock_vkontakte }

      before do
        request.env['omniauth.auth'] = auth
      end

      it 'creates a user' do
        expect { post :create, provider: :vkontakte }.to change{ User.count }.by(1)
      end

      it 'creates an event' do
        expect { post :create, provider: :vkontakte }.to change{ Event.count }.by(1)
      end

      it 'creates a device' do
        expect { post :create, provider: :vkontakte }.to change{ Device.count }.by(1)
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

      it 'saves user token' do
        post :create, provider: :vkontakte
        expect(session[:user_token]).to eq auth.credentials.token
      end

      context 'saves for new user' do
        before do
          post :create, provider: :vkontakte
          @user = User.first
        end

        it 'name' do
          expect(@user.name).to eq 'Bender Rodriguez'
        end

        it 'provider' do
          expect(@user.provider).to eq 'vkontakte'
        end

        it 'uid' do
          expect(@user.uid).to eq '001100010010011110100001101101110011'
        end

        it 'valid birthday' do
          expect(@user.birthday.to_s).to eq '2123-12-10'
        end

        it 'url' do
          expect(@user.url).to eq 'https://vk.com/bender'
        end

        it 'gender' do
          expect(@user.gender).to eq 'male'
        end
      end

      context 'updates for existing user' do
        before do
          post :create, provider: :vkontakte
          @user = User.first
          auth.info.name = 'Redneb Zeugirdor'
          auth.extra.raw_info.bdate = '30.03.2030'
          auth.info.urls.Vkontakte = 'https://vk.com/redneb'
          auth.extra.raw_info.sex = 1
          request.env['omniauth.auth'] = auth
          post :create, provider: :vkontakte
          @user.reload
        end

        it 'name' do
          expect(@user.name).to eq 'Redneb Zeugirdor'
        end

        it 'valid birthday' do
          expect(@user.birthday.to_s).to eq '2030-03-30'
        end

        it 'url' do
          expect(@user.url).to eq 'https://vk.com/redneb'
        end

        it 'gender' do
          expect(@user.gender).to eq 'female'
        end
      end
    end

    context 'odnoklassniki' do
      let!(:auth) { auth_mock_odnoklassniki }

      before do
        request.env['omniauth.auth'] = auth
      end

      it 'creates a user' do
        expect { post :create, provider: :odnoklassniki }.to change{ User.count }.by(1)
      end

      it 'creates an event' do
        expect { post :create, provider: :odnoklassniki }.to change{ Event.count }.by(1)
      end

      it 'creates a device' do
        expect { post :create, provider: :odnoklassniki }.to change{ Device.count }.by(1)
      end

      it 'creates a session' do
        expect(session[:user_id]).to be_nil
        post :create, provider: :odnoklassniki
        expect(session[:user_id]).not_to be_nil
      end

      it 'redirects to the auth link' do
        post :create, provider: :odnoklassniki
        expect(response).to redirect_to widget_path
      end

      it 'saves user token' do
        post :create, provider: :odnoklassniki
        expect(session[:user_token]).to eq auth.credentials.refresh_token
      end

      context 'saves for new user' do
        before do
          post :create, provider: :odnoklassniki
          @user = User.first
        end

        it 'name' do
          expect(@user.name).to eq 'Bender Rodriguez'
        end

        it 'provider' do
          expect(@user.provider).to eq 'odnoklassniki'
        end

        it 'uid' do
          expect(@user.uid).to eq '001100010010011110100001101101110011'
        end

        it 'valid birthday' do
          expect(@user.birthday.to_s).to eq '2123-12-10'
        end

        it 'url' do
          expect(@user.url).to eq 'http://www.odnoklassniki.ru/profile/001100010010011110100001101101110011'
        end

        it 'gender' do
          expect(@user.gender).to eq 'male'
        end
      end

      context 'updates for existing user' do
        before do
          post :create, provider: :odnoklassniki
          @user = User.first
          auth.info.name = 'Redneb Zeugirdor'
          auth.extra.raw_info.birthday = '2030-03-30'
          auth.info.urls.Odnoklassniki = 'http://www.odnoklassniki.ru/profile/bender'
          auth.extra.raw_info.gender = 'female'
          request.env['omniauth.auth'] = auth
          post :create, provider: :odnoklassniki
          @user.reload
        end

        it 'name' do
          expect(@user.name).to eq 'Redneb Zeugirdor'
        end

        it 'valid birthday' do
          expect(@user.birthday.to_s).to eq '2030-03-30'
        end

        it 'url' do
          expect(@user.url).to eq 'http://www.odnoklassniki.ru/profile/bender'
        end

        it 'gender' do
          expect(@user.gender).to eq 'female'
        end
      end
    end

    context 'twitter' do
      let!(:auth) { auth_mock_twitter }

      before do
        request.env['omniauth.auth'] = auth
      end

      it 'creates a user' do
        expect { post :create, provider: :twitter }.to change{ User.count }.by(1)
      end

      it 'creates an event' do
        expect { post :create, provider: :twitter }.to change{ Event.count }.by(1)
      end

      it 'creates a device' do
        expect { post :create, provider: :twitter }.to change{ Device.count }.by(1)
      end

      it 'creates a session' do
        expect(session[:user_id]).to be_nil
        post :create, provider: :twitter
        expect(session[:user_id]).not_to be_nil
      end

      it 'redirects to the widget' do
        post :create, provider: :twitter
        expect(response).to redirect_to widget_path
      end

      it 'saves user token' do
        post :create, provider: :twitter
        expect(session[:user_token]).to eq auth.credentials.token
      end

      it 'saves user secret' do
        post :create, provider: :twitter
        expect(session[:user_secret]).to eq auth.credentials.secret
      end

      context 'saves for new user' do
        before do
          post :create, provider: :twitter
          @user = User.first
        end

        it 'name' do
          expect(@user.name).to eq 'Bender Rodriguez'
        end

        it 'provider' do
          expect(@user.provider).to eq 'twitter'
        end

        it 'uid' do
          expect(@user.uid).to eq '001100010010011110100001101101110011'
        end

        it 'birthday' do
          expect(@user.birthday).to be_nil
        end

        it 'url' do
          expect(@user.url).to eq 'https://twitter.com/bender'
        end

        it 'gender' do
          expect(@user.gender).to be_nil
        end
      end

      context 'updates for existing user' do
        before do
          post :create, provider: :twitter
          @user = User.first
          auth.info.name = 'Redneb Zeugirdor'
          auth.info.urls.Twitter = 'https://twitter.com/redneb'
          request.env['omniauth.auth'] = auth
          post :create, provider: :twitter
          @user.reload
        end

        it 'name' do
          expect(@user.name).to eq 'Redneb Zeugirdor'
        end

        it 'url' do
          expect(@user.url).to eq 'https://twitter.com/redneb'
        end
      end
    end

    context 'instagram' do
      let!(:auth) { auth_mock_instagram }

      before do
        request.env['omniauth.auth'] = auth
      end

      it 'creates a user' do
        expect { post :create, provider: :instagram }.to change{ User.count }.by(1)
      end

      it 'creates an event' do
        expect { post :create, provider: :instagram }.to change{ Event.count }.by(1)
      end

      it 'creates a device' do
        expect { post :create, provider: :instagram }.to change{ Device.count }.by(1)
      end

      it 'creates a session' do
        expect(session[:user_id]).to be_nil
        post :create, provider: :instagram
        expect(session[:user_id]).not_to be_nil
      end

      it 'redirects to the widget' do
        post :create, provider: :instagram
        expect(response).to redirect_to widget_path
      end

      context 'saves for new user' do
        before do
          post :create, provider: :instagram
          @user = User.first
        end

        it 'name' do
          expect(@user.name).to eq 'Bender Rodriguez'
        end

        it 'provider' do
          expect(@user.provider).to eq 'instagram'
        end

        it 'uid' do
          expect(@user.uid).to eq '001100010010011110100001101101110011'
        end

        it 'birthday' do
          expect(@user.birthday).to be_nil
        end

        it 'url' do
          expect(@user.url).to eq 'https://instagram.com/bender'
        end

        it 'gender' do
          expect(@user.gender).to be_nil
        end
      end

      context 'updates for existing user' do
        before do
          post :create, provider: :instagram
          @user = User.first
          auth.info.name = 'Redneb Zeugirdor'
          auth.info.nickname = 'redneb'
          request.env['omniauth.auth'] = auth
          post :create, provider: :instagram
          @user.reload
        end

        it 'name' do
          expect(@user.name).to eq 'Redneb Zeugirdor'
        end

        it 'url' do
          expect(@user.url).to eq 'https://instagram.com/redneb'
        end
      end
    end
  end
end
