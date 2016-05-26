class UsersController < ApplicationController
  def show
    @github_user = GithubUser.new({login: current_user[:login]})
  end
end
