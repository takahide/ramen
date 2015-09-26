class TabelogSearchScraper < Scraper

  def initialize tel
    @tel = tel
    @url = "http://tabelog.com/rstLst/?vs=1&sa=&sk=#{tel}&lid=hd_search1&sw=#{tel}"
  end

  def get_page
    @html = access(@url).to_s
  end

  def html= html
    @html = html
  end

  def restaurant_url
    link = Nokogiri::HTML(@html, nil, 'utf-8').css(".rstlist-info a.list-rst__rst-name-target")
    if link.present?
      return link.attr("href").content
    end
    return nil
  end

  def restaurant_name
    link = Nokogiri::HTML(@html, nil, 'utf-8').css(".rstlist-info a.list-rst__rst-name-target")
    if link.present?
      return link.text
    end
    return nil
  end

  def html
    @html
  end
end
