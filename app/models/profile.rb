class Profile < ActiveRecord::Base
  has_many :repositories
  validates :username, uniqueness: true

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
end
