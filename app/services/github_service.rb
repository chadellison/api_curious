class GithubService
  attr_reader :user, :connection

  def initialize(user)
    @user = user
    @connection = Faraday.new(url: "https://api.github.com/users/")
    @connection.headers["Authorization"] = "token #{user.oauth_token}"
    @query_user = user
  end

  def find(user_name)
    following_hash.detect { |user| user[:login] == user_name}
  end

  def get_organizations
    connection.get "#{@query_user[:login]}/orgs"
  end

  def organizations
    parse(get_organizations)
  end

  def get_events
    connection.get "#{@query_user[:login]}/events"
  end

  def followed_user_summary(followed_user_hash)
    @query_user = followed_user_hash
    {"Commits" => recent_pushes, "Pull Requests" => recent_pull_requests, "Issues" => recent_issues}
  end

  def recent_pushes
    find_event_type("PushEvent").map do |push|
      push[:payload][:commits].map { |commit| commit[:message]}
    end
  end

  def recent_pull_requests
    find_event_type("PullRequestEvent").map do |pull_request|
      pull_request[:payload][:pull_request][:body]
    end
  end

  def recent_issues
    (find_event_type("IssuesEvent") + find_event_type("IssueCommentEvent")).map do |issue|
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

  private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def find_event_type(event_type)
      parse(get_events).select do |event|
        event[:type] == event_type
      end
    end
end
