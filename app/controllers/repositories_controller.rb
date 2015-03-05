class RepositoriesController < ApplicationController

  def index
  end

  def show
    @profile = Profile.find_by_username(params[:username]) ||
        Profile.create_from_username(params[:username])
    @repositories = Repository.find_by_profile_id(@profile.id).all
    if @repositories.nil?
      Repository.create_from_username(params[:username])
    end
  end

end
