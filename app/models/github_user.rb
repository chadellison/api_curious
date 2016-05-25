class GithubUser < OpenStruct
  attr_reader :user, :service

  def initialize(user)
    @user = user
    @service = GithubService.new(user)
  end

  def recent_pushes
    service.recent_pushes
  end

  def recent_pull_requests
    service.recent_pull_requests
  end

  def issues
    service.recent_issues
  end

  def followers
    service.followers_hash
  end

  def following
    service.following_hash
  end

  def starred
    service.starred_hash
  end
end
