require "rails_helper"

feature "visitor can login with github" do
  include Capybara::DSL
  before(:each) do
    Capybara.app = ApiCurious::Application
  end

  scenario "logging in" do
    visit root_path
    expect(page.status_code).to eq 200
    click_on "Sign in with Github"
    expect(current_path).to eq dashboard_path
    expect(page).to have_content "Chad Ellison"
    expect(page).to have_link "Logout"
  end
end
