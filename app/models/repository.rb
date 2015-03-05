class Repository < ActiveRecord::Base
  belongs_to :profile
  validates :url, uniqueness: true

  def self.create_from_username(username)
    @profile = Profile.find_by_username('username')
    response = HTTParty.get(
        "https://api.github.com/users/#{username}/repos?sort=updated",
        :headers => {"Authorization" => "token #{ENV['GITHUB_TOKEN']}",
                     "User-Agent" => "anyone"
                    }
    )
    response.map do |repo|
      Repository.create(
        body: repo,
        profile_id: @profile.id,
        name: repo["name"],
        url: repo["url"],
        fork_number: repo["forks_count"].to_i,
        star_number: repo["stargazers_count"].to_i,
        date_updated: repo["updated_at"].to_datetime,
        language: repo["language"]
      )
    end
  end
end
