class GithubUser < OpenStruct
  attr_reader :user, :service

  def initialize(user)
    @user = user
    @service = GithubService.new(user)
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
