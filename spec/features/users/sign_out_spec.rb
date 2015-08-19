feature 'Sign out', %q{
  As a user
  I want to sign out
  So I can protect my account from unauthorized access
}, :omniauth do

  xscenario 'User signs out successfully', %q{
    Given I am signed in
    When I sign out
    Then I see a signed out message
  } do
    sign_in_facebook
    click_link 'Sign out'
    expect(page).to have_content 'Signed out'
  end

end
