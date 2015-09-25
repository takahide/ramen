class AddHtmlToTsukemenRestaurants < ActiveRecord::Migration
  def change
    add_column :tsukemen_restaurants, :html, :text
  end
end
