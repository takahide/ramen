require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'kconv'

class Cron

  def self.get_same_in_tabelog
    TsukemenRestaurant.find_each do |r|
      next if r.tabelog_url.present?
      next if r.tel.nil? || r.tel.match(/[\d-]*/)[0] == ""
      ls = TabelogSearchScraper.new r.tel
      ls.get_page

      r.tabelog_url = ls.restaurant_url
      r.tabelog_name = ls.restaurant_name
      r.save
    end
  end

  def self.get_tsukemen_pages
    style = "1-2"
    page_max = 121
    ls = RamendbListScraper.new style, page_max
    while (1)
      if ls.get_next_page
        TsukemenPage.create(
          page: ls.page,
          html: ls.html
        )
      else
        break
      end
    end
  end

  def self.tsukemen_pages_to_restaurants
    TsukemenPage.find_each do |p|
      next if p.html.nil?
      ls = RamendbListScraper.new "1-2", 121
      ls.html = p.html
      ls.restaurants.each do |r|
        TsukemenRestaurant.create(
          rank: r.rank,
          url: r.url
        )
      end
    end
  end

  def self.get_tsukemen_restaurant_pages
    TsukemenRestaurant.find_each do |r|
      next if r.html.present?
      s = RamendbRestaurantScraper.new r.url
      s.get_page
      r.html = s.html
      r.save
    end
  end

  def self.get_tsukemen_restaurant_info
    TsukemenRestaurant.find_each do |r|
      s = RamendbRestaurantScraper.new r.url
      s.html = r.html

      r.name = s.name
      r.address = s.address
      r.prefecture = s.prefecture
      r.city = s.city
      r.tel = s.tel
      r.opening_hours = s.opening_hours
      r.closed = s.closed
      r.seats = s.seats
      r.smoke = s.smoke
      r.station = s.station
      r.station_id = s.station_id
      r.parking = s.parking
      r.since = s.since
      r.menu = s.menu
      r.note = s.note
      r.map = s.map
      r.close_restaurants = s.close_restaurants.join(",") if s.close_restaurants.present?
      r.save
    end
  end

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
