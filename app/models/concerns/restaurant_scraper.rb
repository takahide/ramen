class RestaurantScraper < Scraper

  def initialize url
    @url = url
  end

  def get_page
    @html = access(@url).to_s
  end

  def html= html
    @html = html
  end

  def name
    Nokogiri::HTML(@html, nil, 'utf-8').css(".display-name").text
  end

  def score
    Nokogiri::HTML(@html, nil, 'utf-8').css("#rdhead-info-box .score span").text
  end

  def html
    @html
  end
end
