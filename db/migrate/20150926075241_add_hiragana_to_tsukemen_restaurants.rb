class AddHiraganaToTsukemenRestaurants < ActiveRecord::Migration
  def change
    add_column :tsukemen_restaurants, :hiragana, :string
  end
end
