feature 'Home page', %q{
  As a visitor
  I want to visit a home page
  So I can learn more about the website
} do

  scenario 'Visit the home page', %q{
    Given I am a visitor
    When I visit the home page
    Then I see "Welcome"
  } do
    visit root_path
    expect(page).to have_content 'Welcome'
  end

end
