class AdminController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end
end
