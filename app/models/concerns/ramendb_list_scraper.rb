class RamendbListScraper < Scraper

  def initialize style, page_max
    @style = style
    @urls = []
    @index = 0
    for page in 1..page_max
      @urls.push "http://ramendb.supleks.jp/rank?page=#{page}&style=#{style}"
    end
  end

  def get_next_page
    @html = access(@urls[@index]).to_s
    if @html.include?('<td class="rank">')
      @index += 1
      return true
    end
    return false
  end

  def html= html
    @html = html
  end

  class Restaurant
    attr_accessor :rank, :url
    def initialize rank, url
      @rank = rank
      @url = url
    end
  end

  def restaurants
    r = []
    honor = Nokogiri::HTML(@html, nil, 'utf-8').css("#honor")
    if honor.present?
      honor.css("li").each_with_index do |li, i|
        rank = i + 1
        url = li.css(".name a").attr("href")
        r.push Restaurant.new rank, url
      end
    end

    Nokogiri::HTML(@html, nil, 'utf-8').css(".ranks table tr").each do |tr|
      rank = tr.css("td.rank").text.gsub(/"/, "")
      url = tr.css("td .name a").attr("href")
      r.push Restaurant.new rank, url
    end
    r
  end

  def style
    @style
  end

  def page
    @index
  end

  def html
    @html
  end
end
