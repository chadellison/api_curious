class GithubUser < OpenStruct
  attr_accessor :name, :service

  def initialize(user)
    @user = user
    @service = GithubService.new(user)
  end

  def organizations
    service.organizations
  end

  def repos
    service.repos.map do |repo|
      repo[:name]
    end
  end

  def find(user_name)
    service.find(user_name)
  end

  def recent_pushes
    service.recent_pushes
  end

  def recent_pull_requests
    # raw_pull_requests = service.recent_pull_requests
    # raw_pull_requests.map do |raw_pr|
    #   GithubPullRequest.new(raw_pr)
    # end
    service.recent_pull_requests
  end

  def issues
    service.recent_issues
  end

  # user.orders # => [<Order>, <Order>]
  # user.orders.first.amount

  def followers
    service.followers_hash
  end

  # github_user.followers #=> [<GithubUser>, <GithubUser>]

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
