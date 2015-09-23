class AddHtmlToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :html, :text
  end
end
