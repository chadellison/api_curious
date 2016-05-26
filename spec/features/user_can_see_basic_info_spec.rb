require "rails_helper"

feature "user can see basic info" do
  include Capybara::DSL
  before(:each) do
    Capybara.app = ApiCurious::Application
  end

  VCR.use_cassette "omniauth_login" do
    scenario "user sees photo, followers, following, and number of starred repos" do
      visit root_path
      click_on "Sign in with Github"
      expect(current_path).to eq dashboard_path
      expect(page).to have_content "Repositories"
      expect(page).to have_xpath("//img[@src=\"https://avatars.githubusercontent.com/u/13648884?v=3\"]")
      expect(page).to have_content "Followers: 9"
      expect(page).to have_content "Following: 13"
      expect(page).to have_content "Starred: 0"
      expect(page).to have_content "Organizations:"
      expect(page).to have_content "Commits"
      expect(page).to have_content "Pull Requests"
      expect(page).to have_content "Issues"
    end
  end
end
