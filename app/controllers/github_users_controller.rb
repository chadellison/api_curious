class GithubUsersController < ApplicationController
  def index
    @followed_users = GithubUser.new(login: current_user[:login]).followers
  end

  def show
    @github_user = GithubUser.new(login: params[:login])
  end
end
