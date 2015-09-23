class CreateRankingPages < ActiveRecord::Migration
  def change
    create_table :ranking_pages do |t|
      t.string :prefecture
      t.integer :page
      t.text :html

      t.timestamps null: false
    end
  end
end
