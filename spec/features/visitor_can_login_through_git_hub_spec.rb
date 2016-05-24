require "rails_helper"

feature "visitor can login with github" do
  include Capybara::DSL

  scenario "logging in" do
    Capybara.app = ApiCurious::Application

    visit "/"
    assert_equal 200, page.status_code
  end
end
