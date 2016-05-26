class GithubUser < OpenStruct
  attr_accessor :name, :service

  def initialize(user)
    @name = user[:login]
    @service = GithubService.new(@name)
  end

  def organizations
    service.organizations
  end

  def repos
    service.repos.map do |repo|
      repo[:name]
    end
  end

  def recent_pushes
    service.recent_pushes.map do |push|
      push[:payload][:commits].map { |commit| commit[:message]}
    end
  end

  def recent_pull_requests
    service.recent_pull_requests.map do |pull_request|
      pull_request[:payload][:pull_request][:body]
    end
  end

  def issues
    service.recent_issues.map do |issue|
      [issue[:payload][:issue][:title], "Repo: #{issue[:repo][:name]}", issue[:payload][:action]]
    end
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
