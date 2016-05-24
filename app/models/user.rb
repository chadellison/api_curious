class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.name               = auth_info.extra.raw_info.name
      new_user.screen_name        = auth_info.extra.raw_info.screen_name
      new_user.oauth_token        = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
      new_user.avatar_url         = auth_info.extra.raw_info.avatar_url
      new_user.followers_url      = auth_info.extra.raw_info.followers_url
      new_user.following_url      = auth_info.extra.raw_info.following_url
      new_user.starred_url        = auth_info.extra.raw_info.starred_url
      new_user.login              = auth_info.extra.raw_info.login
    end
  end

  def followers
    response = Faraday.get("https://api.github.com/users/#{login}/followers")
    JSON.parse(response.body)
  end

  def following
    response = Faraday.get("https://api.github.com/users/#{login}/following")
    JSON.parse(response.body)
  end

  def starred
    response = Faraday.get("https://api.github.com/users/#{login}/starred")
    JSON.parse(response.body)
  end
end
