class UsersController < ApplicationController
  def show
    @user = GithubService.new(current_user)
  end
end
