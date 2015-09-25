class RamendbRestaurantScraper < Scraper

  def initialize url
    @url = "http://ramendb.supleks.jp" + url
  end

  def get_page
    @html = access(@url).to_s
  end

  def html= html
    @html = html
  end

  def html
    @html
  end
end
