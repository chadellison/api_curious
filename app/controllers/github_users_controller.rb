class GithubUsersController < ApplicationController
  def index
    @followed_users = GithubUser.new(current_user).followers
  end

  def show
    @followed_user = GithubUser.new(current_user).find(params[:name])
    @github_user = GithubUser.new(current_user).followed_user_summary(@followed_user)
  end
end
