class AddAreaToRankingPages < ActiveRecord::Migration
  def change
    add_column :ranking_pages, :area, :string
  end
end
