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
      expect(page).to have_link "treyx"
      expect(page).to have_link "damwhit"
      expect(page).to have_link "thompickett"
      expect(page).to have_link "brianrip"
      expect(page).to have_link "MDes41"
      expect(page).to have_link "Carmer"
      expect(page).to have_link "adamhundley"
      expect(page).to have_link "natevenn"
      expect(page).to have_link "NickyBobby"
    end
  end
end
