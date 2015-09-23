class AddPicturesToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :first_picture, :string
    add_column :restaurants, :second_picture, :string
    add_column :restaurants, :third_picture, :string
  end
end
