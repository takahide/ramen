class SearchController < ApplicationController
  def suggest
    q = params[:q]
    if q.size >= 1
      restaurants = TsukemenRestaurant.where("hiragana like ? or name like ?", "%#{q}%", "%#{q}%").select("id, name")
    else
      restaurants = nil
    end
    render json: restaurants
  end
end
