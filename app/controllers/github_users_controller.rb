class GithubUsersController < ApplicationController
  def index
    if params[:type] == "following"
      @users = GithubUser.new(login: current_user[:login]).following
    else
      @users = GithubUser.new(login: current_user[:login]).followers
    end
  end

  def show
    @github_user = GithubUser.new(login: params[:login])
  end
end
