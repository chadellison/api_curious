require "rails_helper"

feature "user can see basic info" do
    include Capybara::DSL
    before(:each) do
      Capybara.app = ApiCurious::Application
    end

  scenario "user sees photo, followers, following, and number of starred repos" do

    visit root_path
    click_on "Sign in with Github"
    expect(current_path).to eq dashboard_path
    expect(page).to have_xpath("//img[@src=\"https://avatars.githubusercontent.com/u/13648884?v=3\"]")
    expect(page).to have_content "Followers: 2"
    expect(page).to have_content "Following: 2"
    expect(page).to have_content "Starred: 2"
  end
end
