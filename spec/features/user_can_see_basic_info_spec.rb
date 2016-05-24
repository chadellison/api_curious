require "rails_helper"

feature "user can see basic info" do
    include Capybara::DSL
    before(:each) do
      Capybara.app = ApiCurious::Application
      stub_omniauth
    end

  scenario "user sees photo, followers, following, and number of starred repos" do

    visit root_path
    click_on "Sign in with Github"
    expect(current_path).to eq dashboard_path
    expect(page).to have_xpath("//img[@src=\"https://avatars1.githubusercontent.com/u/1227440?v=3&s=460\"]")
    expect(page).to have_content "Followers: 2"
    expect(page).to have_content "Following: 2"
    expect(page).to have_content "Starred: 2"
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      extra: {
        raw_info: {
          user_id: "1234",
          name: "Horace",
          screen_name: "worace",
          avatar_url: "https://avatars1.githubusercontent.com/u/1227440?v=3&s=460",
        }
      },
      credentials: {
        token: "pizza",
        secret: "secretpizza"
      }
    })
  end
end
