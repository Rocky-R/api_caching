class Profile < ActiveRecord::Base
  validates :username, uniqueness: true

  # def initialize(username)
  #   @username = username
  # end

  def self.create_from_username(username)
    profile = nil
    response = HTTParty.get(
        "https://api.github.com/users/#{username}",
        :headers => {"Authorization" => "token #{ENV['GITHUB_TOKEN']}",
                     "User-Agent" => "anyone"
                    }
    )
    if response["login"]
      profile = Profile.create(
        body: response,
        username: response["login"],
        following: response["following"],
        follower_number: response["followers"],
        company_name: response["company_name"],
        location: response["location"],
        username: response["login"],
        avatar_url: response["avatar_url"]
      )
    end
    profile
  end

  # def username
  #   @content["login"]
  # end

  # def avatar_url
  #   @content["avatar_url"]
  # end
  #
  # def location
  #   @content["location"]
  # end
  #
  # def company_name
  #   @content["company"]
  # end
  #
  # def number_of_followers
  #   @content["followers"]
  # end
  #
  # def number_following
  #   @content["following"]
  # end

end
