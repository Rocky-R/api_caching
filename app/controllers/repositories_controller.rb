class RepositoriesController < ApplicationController

  def index
  end

  def show
    @profile = Profile.find_by_username(params[:username]) ||
        Profile.create_from_username(params[:username])
    @repositories = Repository.where(profile_id: @profile.id).all
    if @repositories.empty?
      Repository.create_from_username(params[:username])
    end
  end

end
