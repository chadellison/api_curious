class GithubService
  attr_reader :user
  attr_reader :connection

  def initialize(user)
    @user = user
    @connection = Faraday.new(url: "https://api.github.com/users/")
    @connection.headers["Authorization"] = "token #{user.oauth_token}"
  end

  def get_events
    connection.get "#{user.login}/events"
  end

  def recent_pushes
    parse(get_events).select do |event|
      event[:type] == "PushEvent"
    end.map do |push|
      push[:payload][:commits].map { |commit| commit[:message]}
    end
  end

  # def recent_repos
  #   parse(get_events).select do |event|
  #     event[:type] == "CreateEvent"
  #   end.map do |repo|
  #     [repo[:repo][:name], [:payload][:ref]]
  #   end
  # end

  def recent_pull_requests
    parse(get_events).select do |event|
      event[:type] == "PullRequestEvent"
    end.map do |pull_request|
      pull_request[:payload][:pull_request][:body]
    end
  end

  def recent_issues
    parse(get_events).select do |event|
      event[:type] == "IssuesEvent" || event[:type] == "IssueCommentEvent"
    end.map do |issue|
      [issue[:payload][:issue][:title], "Repo: #{issue[:repo][:name]}", issue[:payload][:action]]
    end
  end

  def get_followers
    connection.get "#{user.login}/followers"
  end

  def followers_hash
    parse(get_followers)
  end

  def get_following
    connection.get "#{user.login}/following"
  end

  def following_hash
    parse(get_following)
  end

  def get_starred
    connection.get "#{user.login}/starred"
  end

  def starred_hash
    parse(get_starred)
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
