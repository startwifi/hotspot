module Omniauth

  module Mock
    def auth_mock_facebook
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        'provider' => 'facebook',
        'uid' => '123545',
        'info' => {
          'name' => 'mockuser',
          'urls' => { 'Facebook' => 'http://facebook.com/uid/12345678' }
        },
        'extra' => {
          'raw_info' => {
            'birthday' => '8/24/1991'
          }
        },
        'credentials' => {
          'token' => 'mock_token',
          'secret' => 'mock_secret'
        }
      })
    end

    def auth_mock_vkontakte
      OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new({
        'provider' => 'vkontakte',
        'uid' => '123545',
        'info' => {
          'name' => 'mockuser',
          'urls' => { 'Vkontakte' => 'http://vk.com/username' }
        },
        'extra' => {
          'raw_info' => {
            'birthday' => '8/24/1991'
          }
        },
        'credentials' => {
          'token' => 'mock_token',
          'secret' => 'mock_secret'
        }
      })
    end
  end

  module SessionHelpers
    def sign_in_facebook
      visit auth_path
      expect(page).to have_content 'Facebook'
      auth_mock_facebook
      click_link 'Facebook'
    end

    def sign_in_vk
      visit auth_path
      expect(page).to have_content 'Vkontakte'
      auth_mock_vkontakte
      click_link 'Vkontakte'
    end

    def sign_in_twitter
      visit auth_path
      expect(page).to have_content 'Vkontakte'
      auth_mock
      click_link 'Vkontakte'
    end
  end

end
