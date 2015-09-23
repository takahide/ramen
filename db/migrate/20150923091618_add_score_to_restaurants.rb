class AddScoreToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :score, :string
  end
end
