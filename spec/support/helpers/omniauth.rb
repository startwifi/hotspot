module Omniauth
  module Mock
    def auth_mock_facebook
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        'provider': 'facebook',
        'uid': '001100010010011110100001101101110011',
        'info': {
          'name': 'Bender Rodriguez',
          'image': 'http://graph.facebook.com/001100010010011110100001101101110011/picture',
          'urls': {
            'Facebook': 'https://www.facebook.com/app_scoped_user_id/001100010010011110100001101101110011'
          }
        },
        'credentials': {
          'token': 'CAALRPk09UNoBANrfZCXIdZBfkxd8zICH535DZAhds1QCs6lQkZAwS3kTzyLd5EW7NID0RNoPHlksn6vf0C9Di3Qa',
          'expires_at': (Time.zone.now + 12.hours).to_i,
          'expires': true
        },
        'extra':{
          'raw_info': {
            'birthday':'12/10/2123',
            'name': 'Bender Rodriguez',
            'link': 'https://www.facebook.com/app_scoped_user_id/001100010010011110100001101101110011/',
            'id': '001100010010011110100001101101110011'
          }
        }
      })
    end

    def auth_mock_vkontakte
      OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new({
        'provider': 'vkontakte',
        'uid': '001100010010011110100001101101110011',
        'info': {
          'name': 'Bender Rodriguez',
          'nickname': '',
          'email': nil,
          'first_name': 'Bender',
          'last_name': 'Rodriguez',
          'image': 'http://cs12345.vk.me/v23232323/768/Jke3BTKyRGY.jpg',
          'location': 'USA, New York',
          'urls': {
            'Vkontakte': 'https://vk.com/bender'
          }
        },
        'credentials': {
          'token': '1d1274854697f9b9f5975088d797c679bcd6b2e84f0e94ace8d386cd2b8128d764bfc9755f9304f6061ae',
          'expires_at': (Time.zone.now + 12.hours).to_i,
          'expires': true
        },
        'extra': {
          'raw_info': {
            'id': '001100010010011110100001101101110011',
            'first_name': 'Bender',
            'last_name': 'Rodriguez',
            'sex': 2,
            'nickname': '',
            'screen_name': 'bender',
            'bdate': '10.12.2123',
            'city': 10,
            'country': 2,
            'photo_50': 'http://cs12345.vk.me/v3212332/321/sd3asdb43.jpg',
            'photo_100': 'http://cs12345.vk.me/v3212332/321/sd3asdb43.jpg',
            'photo_200_orig': 'http://cs12345.vk.me/v3212332/321/sd3asdb43.jpg',
            'online': 0
          }
        }
      })
    end

    def auth_mock_twitter
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        'provider': 'twitter',
        'uid': '001100010010011110100001101101110011',
        'info': {
          'nickname': 'bender',
          'name': 'Bender Rodriguez',
          'email': nil,
          'location': 'USA, New York',
          'image':'http://pbs.twimg.com/profile_images/11101110011/bender_normal.png',
          'description': 'Kill all humans',
          'urls': {
            'Website': 'http://t.co/xxxxxxxxx',
            'Twitter': 'https://twitter.com/bender'
          }
        },
        'credentials': {
          'token': '001100010010011110100001101101110011-KRwAcunrpci4Ef6cgqC25J6PmRWdjv8FF8OSbM5Tks',
          'secret': 'w0ft2Y4SNSNe1aL0Gbxg7TIPLva7fUE9UDgne7WhU3FP5'
        },
        'extra': {
          'access_token': {
            'token': '001100010010011110100001101101110011-KRwAcunrpci4Ef6cgqC25J6PmRWdjv8FF8OSbM5Tks',
            'secret': '40ft2Y4SNSNe1aL0Gbxg7TIPLva7fUE9UDgne7WhU3FP5',
            'consumer': {
              'key': 'Gsywwjdp98SyfPasJVRSUrTKl',
              'secret': 'ZHcksZid2MvVRhFWzj2yNdCbYLoVUawYcsXACnvvbJ1AXloXKn'
            }
          }
        }
      })
    end

    def auth_mock_odnoklassniki
      OmniAuth.config.mock_auth[:odnoklassniki] = OmniAuth::AuthHash.new({
        'provider': 'odnoklassniki',
        'uid': '001100010010011110100001101101110011',
        'info': {
          'name': 'Bender Rodriguez',
          'first_name': 'Bender',
          'last_name': 'Rodriguez',
          'image': 'https://i504.mycdn.me/image',
          'urls': {
            'Odnoklassniki': 'http://www.odnoklassniki.ru/profile/001100010010011110100001101101110011'
          }
        },
        'credentials': {
          'token': '2aip8uxk05w2h111axz3k1ksrvk1641.3',
          'refresh_token': '652932b6572077c7a6159a82300d09b0e2dba2_199936599_147275',
          'expires_at': (Time.zone.now + 12.hours).to_i,
          'expires': true
        },
        'extra': {
          'raw_info': {
            'uid': '001100010010011110100001101101110011',
            'birthday': '2123-12-10',
            'age': 8,
            'name': 'Bender Rodriguez',
            'locale': 'en',
            'gender': 'male',
            'location': {
              'city': 'New York',
              'country': 'USA',
              'countryCode': 'US',
              'countryName': 'United States'
            },
            'online': 'web',
            'first_name': 'Bender',
            'last_name': 'Rodriguez',
            'has_email': true,
            'photo_id': '123456789',
            'pic_1':'https://i504.mycdn.me/image',
            'pic_2':'https://i.mycdn.me/image',
            'pic_3':'https://i504.mycdn.me/image'
          }
        }
      })
    end

    def auth_mock_instagram
      OmniAuth.config.mock_auth[:instagram] = OmniAuth::AuthHash.new({
        'provider': 'instagram',
        'uid': '001100010010011110100001101101110011',
        'info': {
          'nickname': 'bender',
          'name': 'Bender Rodriguez',
          'image':'https://scontent.cdninstagram.com/t51.2885-19/381640380_a.jpg',
          'bio': 'I live in Ukraine.',
          'website': 'http://planetexpress.com'
        },
        'credentials': {
          'token': '001100010010011110100001101101110011.4ada297.0ba78436654145bb9b472abfa93e8b71',
          'expires': false
        },
        'extra': {}
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
