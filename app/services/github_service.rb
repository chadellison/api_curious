class GithubService
  attr_reader :connection

  def initialize(user_name)
    @connection = Faraday.new(url: "https://api.github.com/users/#{user_name}")
    @connection.headers["Authorization"] = "token #{ENV["oauth_token"]}"
  end

  def user
    parse(get_user)
  end

  def organizations
    parse(get_organizations)
  end

  def repos
    parse(get_repos)
  end

  def recent_pushes
    find_event_type("PushEvent")
  end

  def recent_pull_requests
    find_event_type("PullRequestEvent")
  end

  def recent_issues
    find_event_type("IssuesEvent") + find_event_type("IssueCommentEvent")
  end

  def followers_hash
    parse(get_followers)
  end

  def following_hash
    parse(get_following)
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

    def get_followers
      connection.get "followers"
    end

    def get_starred
      connection.get "starred"
    end

    def get_following
      connection.get "following"
    end

    def get_organizations
      connection.get "orgs"
    end

    def get_events
      connection.get "events"
    end

    def get_repos
      connection.get "repos"
    end

    def get_user
      connection.get
    end
end
