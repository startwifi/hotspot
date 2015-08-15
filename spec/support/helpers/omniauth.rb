module Omniauth

  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:facebook] = {
        'provider' => 'facebook',
        'uid' => '123545',
        'info' => {
          'name' => 'mockuser'
        },
        'credentials' => {
          'token' => 'mock_token',
          'secret' => 'mock_secret'
        }
      }
    end
  end

  module SessionHelpers
    def sign_in_facebook
      visit root_path
      expect(page).to have_content 'Facebook'
      auth_mock
      click_link 'Facebook'
    end

    def sign_in_vk
      visit root_path
      expect(page).to have_content 'Vkontakte'
      auth_mock
      click_link 'Vkontakte'
    end

    def sign_in_twitter
      visit root_path
      expect(page).to have_content 'Vkontakte'
      auth_mock
      click_link 'Vkontakte'
    end
  end

end
