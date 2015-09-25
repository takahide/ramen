class CreateTsukemenRestaurants < ActiveRecord::Migration
  def change
    create_table :tsukemen_restaurants do |t|
      t.string :url
      t.integer :rank

      t.timestamps null: false
    end
  end
end
