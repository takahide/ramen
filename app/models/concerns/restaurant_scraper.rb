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

  def first_picture
    imgs = Nokogiri::HTML(@html, nil, 'utf-8').css("ul.rstdtl-top-photo__list .rstdtl-top-photo__photo img")
    if imgs.present?
      imgs[0].attr("src")
    end
  end

  def second_picture
    imgs = Nokogiri::HTML(@html, nil, 'utf-8').css("ul.rstdtl-top-photo__list .rstdtl-top-photo__photo img")
    if imgs.present? and imgs.size > 1
      imgs[1].attr("src")
    end
  end

  def third_picture
    imgs = Nokogiri::HTML(@html, nil, 'utf-8').css("ul.rstdtl-top-photo__list .rstdtl-top-photo__photo img")
    if imgs.present? and imgs.size > 2
      imgs[2].attr("src")
    end
  end

  def html
    @html
  end
end
