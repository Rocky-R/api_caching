class AddProfileIdToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :profile_id, :integer
  end
end
