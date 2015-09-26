class AddInfoToTsukemenRestaurants < ActiveRecord::Migration
  def change
    add_column :tsukemen_restaurants, :name, :string
    add_column :tsukemen_restaurants, :address, :string
    add_column :tsukemen_restaurants, :prefecture, :string
    add_column :tsukemen_restaurants, :city, :string
    add_column :tsukemen_restaurants, :tel, :string
    add_column :tsukemen_restaurants, :open, :string
    add_column :tsukemen_restaurants, :closed, :string
    add_column :tsukemen_restaurants, :seats, :string
    add_column :tsukemen_restaurants, :smoke, :string
    add_column :tsukemen_restaurants, :station, :string
    add_column :tsukemen_restaurants, :station_id, :string
    add_column :tsukemen_restaurants, :parking, :string
    add_column :tsukemen_restaurants, :since, :string
    add_column :tsukemen_restaurants, :menu, :string
    add_column :tsukemen_restaurants, :note, :string
    add_column :tsukemen_restaurants, :map, :string
    add_column :tsukemen_restaurants, :close_restaurants, :string
  end
end
