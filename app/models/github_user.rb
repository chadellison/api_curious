class GithubUser < OpenStruct
  attr_accessor :name, :service

  def initialize(user)
    @user = user
    @service = GithubService.new(user)
  end

  def find(user_name)
    service.find(user_name)
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

  def followed_user_summary(followed_user)
    service.followed_user_summary(followed_user)
  end
end
