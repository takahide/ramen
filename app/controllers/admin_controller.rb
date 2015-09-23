class AdminController < ApplicationController
  def index
    @restaurants = Restaurant.all
    render layout: "admin"
  end
end
