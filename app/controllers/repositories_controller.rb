class RepositoriesController < ApplicationController

  def index
  end

  def show
    @profile = Profile.find_by_username(params[:username]) ||
        Profile.create_from_username(params[:username])
    @profile.destroy if @profile.updated_at < (Time.now - 24.hours)

    @repositories = Repository.where(profile_id: @profile.id).all
    Repository.create_from_username(params[:username]) if @repositories.empty?
    Repository.where(profile_id: @profile.id).delete_all if Repository.where(
        profile_id: @profile.id).first.updated_at < (Time.now - 2.hours)
  end

end
