class TopController < ApplicationController
  def index
    @prefectures = Prefecture.all
  end
end
