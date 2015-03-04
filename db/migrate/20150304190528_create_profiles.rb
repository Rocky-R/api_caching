class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.binary :body
      t.string :username
      t.string :avatar_url
      t.string :location
      t.string :company_name
      t.integer :follower_number
      t.integer :following

      t.timestamps null: false
    end
  end
end
