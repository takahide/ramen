class ChangeOpenNameToTsukemenRestaurants < ActiveRecord::Migration
  def change
    rename_column :tsukemen_restaurants, :open, :opening_hours
  end
end
