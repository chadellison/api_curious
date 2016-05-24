class GithubService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def followers
    response = Faraday.get("https://api.github.com/users/#{user.login}/followers")
    JSON.parse(response.body)
  end

  def following
    response = Faraday.get("https://api.github.com/users/#{user.login}/following")
    JSON.parse(response.body)
  end

  def starred
    response = Faraday.get("https://api.github.com/users/#{user.login}/starred")
    JSON.parse(response.body)
  end
end
