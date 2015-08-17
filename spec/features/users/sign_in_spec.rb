feature 'Sign in', %q{
  As a user
  I want to sign in
  So I can visit protected areas of the site
}, :omniauth do

  scenario 'User can sign in with valid account', %q{
    Given I have a valid account
    And I am not signed in
    When I sign in
    Then I see a success message
  } do
    sign_in_facebook
    expect(page).to have_content('Sign out')
  end

  scenario 'User cannot sign in with invalid account', %q{
    Given I have no account
    And I am not signed in
    When I sign in
    Then I see an authentication error message
  } do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit social_path
    expect(page).to have_content('Facebook')
    click_link 'Facebook'
    expect(page).to have_content('Authentication error')
  end

end
