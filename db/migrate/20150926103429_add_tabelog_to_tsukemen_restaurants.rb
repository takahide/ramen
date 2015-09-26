class AddTabelogToTsukemenRestaurants < ActiveRecord::Migration
  def change
    add_column :tsukemen_restaurants, :tabelog_url, :string
    add_column :tsukemen_restaurants, :tabelog_name, :string
  end
end
