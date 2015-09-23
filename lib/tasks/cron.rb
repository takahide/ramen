require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'kconv'

class Cron

  def self.get_tokyo_pages
    prefecture = "tokyo"
    code = "A"
    area_min = 1301
    area_max = 1331

    ls = ListScraper.new prefecture, code, area_min, area_max
    while (1)
      r =ls.get_next_page
      if r == 0
        RankingPage.create(
          prefecture: ls.prefecture,
          area: ls.area,
          page: ls.page,
          html: ls.html
        )
      elsif r == 2
        break
      end
    end
  end

  def self.ranking_pages_to_restaurants
    RankingPage.find_each do |p|
      next if p.html.nil?
      html = Nokogiri::HTML(p.html, nil, 'utf-8')
      restaurants = html.css(".list-rst__rst-name-target") 
      restaurants.each do |r|
        Restaurant.where(url: r.attr("href")).first_or_create
      end
    end
  end

  def self.get_restaurant_pages
    Restaurant.find_each do |r|
      s = RestaurantScraper.new r.url
      s.get_page
      r.html = s.html
      r.save
    end
  end

  def self.get_restaurant_info
    Restaurant.find_each do |r|
      s = RestaurantScraper.new r.url
      s.html = r.html

      r.name = s.name
      r.score = s.score
      r.first_picture = s.first_picture
      r.second_picture = s.second_picture
      r.third_picture = s.third_picture
      r.save
    end
  end

  def self.access url, sec=1
    sleep(rand(3) + sec)
    method_name = caller[0][/`([^']*)'/, 1]
    logger = Logger.new "log/runner/#{method_name.split(" ").last}.log"
    logger.debug "Accessing #{url}"
    Nokogiri::HTML(open(url).read.toutf8, nil, 'utf-8')
  end

  def self.ssl_access url, sec=1
    sleep(rand(2) + sec)
    method_name = caller[0][/`([^']*)'/, 1]
    logger = Logger.new "log/runner/#{method_name.split(" ").last}.log"
    logger.debug "Accessing #{url}"
    Nokogiri::HTML(open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read.toutf8, nil, 'utf-8')
  end
end
