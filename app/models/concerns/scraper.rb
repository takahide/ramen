require 'nokogiri'
require 'open-uri'
require 'kconv'

class Scraper
  def debug str
    method_name = caller[0][/`([^']*)'/, 1]
    logger = Logger.new "log/runner/#{method_name.split(" ").last}.log"
    logger.debug str
  end

  def access url
    sleep(rand(1) + 1)
    method_name = caller[0][/`([^']*)'/, 1]
    logger = Logger.new "log/runner/#{method_name.split(" ").last}.log"
    logger.debug "Accessing #{url}"
    Nokogiri::HTML(open(url).read.toutf8, nil, 'utf-8')
  end
end
