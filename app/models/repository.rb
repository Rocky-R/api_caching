class Repository < ActiveRecord::Base
  validates :name, uniqueness: true

  def self.create_from_username(username)
    response = HTTParty.get(
        "https://api.github.com/users/#{username}/repos?sort=updated",
        :headers => {"Authorization" => "token #{ENV['GITHUB_TOKEN']}",
                     "User-Agent" => "anyone"
                    }
    )
    response.map do |repo|
      Repository.create(
        body: repo,
        name: repo["name"],
        url: repo["url"],
        fork_number: repo["forks_count"].to_i,
        star_number: repo["stargazers_count"].to_i,
        date_updated: repo["updated_at"].to_datetime,
        language: repo["language"]
      )
    end
  end

  # def initialize(content)
  #   @content = content
  # end
  #
  # def name
  #   @content["name"]
  # end
  #
  # def url
  #   @content["url"]
  # end
  #
  # def number_of_forks
  #   @content["forks_count"].to_i
  # end
  #
  # def number_of_stars
  #   @content["stargazers_count"].to_i
  # end
  #
  # def updated_at
  #   @content["updated_at"].to_datetime
  # end
  #
  # def language
  #   @content["language"]
  # end
end
