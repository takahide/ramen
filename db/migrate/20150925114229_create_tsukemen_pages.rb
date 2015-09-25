class CreateTsukemenPages < ActiveRecord::Migration
  def change
    create_table :tsukemen_pages do |t|
      t.integer :page
      t.text :html

      t.timestamps null: false
    end
  end
end
