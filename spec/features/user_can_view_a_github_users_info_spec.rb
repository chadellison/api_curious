require "rails_helper"

feature "user can view other github users" do
  include Capybara::DSL
  before(:each) do
    Capybara.app = ApiCurious::Application
  end

  VCR.use_cassette "omniauth_login" do
    scenario "logging in" do
      visit root_path
      click_on "Sign in with Github"
      click_on "Following"
      click_on "thompickett"
      expect(current_path).to eq "/users/thompickett"
      expect(page).to have_content "thompickett"
      expect(page).to have_content "Repositories"
      expect(page).to have_content "Organizations"
      expect(page).to have_content "Contribution Activity:"
    end
  end
end
