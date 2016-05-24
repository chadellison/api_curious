require "rails_helper"

feature "visitor can login with github" do
  include Capybara::DSL
  before(:each) do
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end

  scenario "logging in" do


    visit root_path
    expect(page.status_code).to eq 200
    click_on "Sign in with Github"
    expect(current_path).to eq root_path
    expect(page).to have_content "Horace"
    expect(page).to have_link "Logout"
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      extra: {
        raw_info: {
          user_id: "1234",
          name: "Horace",
          screen_name: "worace"
        }
      },
      credentials: {
        token: "pizza",
        secret: "secretpizza"
      }
    })
  end
end
