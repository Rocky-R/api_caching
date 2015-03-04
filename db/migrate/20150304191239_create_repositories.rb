class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.binary :body
      t.string :name
      t.string :url
      t.integer :fork_number
      t.integer :star_number
      t.datetime :date_updated
      t.string :language

      t.timestamps null: false
    end
  end
end
