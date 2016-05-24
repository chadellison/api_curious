class GithubService
  attr_reader :user
  attr_reader :connection

  def initialize(user)
    @user = user
    @connection = Faraday.new(url: "https://api.github.com/users/")
    @connection.headers["Authorization"] = "token #{user.oauth_token}"
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
