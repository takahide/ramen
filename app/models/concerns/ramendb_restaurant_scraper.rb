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

  def name
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td span").text if tr.css("th").text == "店名"
    end
    return nil
  end

  def hiragana
    furigana = Nokogiri::HTML(@html, nil, 'utf-8').css(".furigana span")
    return furigana.text if furigana.present?
    return nil
  end

  def address
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td").text if tr.css("th").text == "住所"
    end
    return nil
  end

  def prefecture
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td a")[0].text if tr.css("th").text == "住所"
    end
    return nil
  end

  def city
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td a")[1].text if tr.css("th").text == "住所"
    end
    return nil
  end

  def tel
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td").text if tr.css("th").text == "電話番号"
    end
    return nil
  end

  def opening_hours
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td").text if tr.css("th").text == "営業時間"
    end
    return nil
  end

  def closed
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td").text if tr.css("th").text == "定休日"
    end
    return nil
  end

  def seats
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td").text if tr.css("th").text == "席数"
    end
    return nil
  end

  def smoke
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td").text if tr.css("th").text == "喫煙"
    end
    return nil
  end

  def station
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td div").text if tr.css("th").text == "最寄り駅"
    end
    return nil
  end

  def station_id
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td div a").attr("href").content.split("id=")[1] if tr.css("th").text == "最寄り駅"
    end
    return nil
  end

  def parking
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td").text if tr.css("th").text == "駐車場"
    end
    return nil
  end

  def since
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td").text if tr.css("th").text == "開店日"
    end
    return nil
  end

  def menu
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      if tr.css("th").text == "メニュー"
        if tr.css("td .more")
          return tr.css("td .more").text.gsub(/元に戻す/, "")
        end
        return tr.css("td").text
      end
    end
    return nil
  end

  def note
    Nokogiri::HTML(@html, nil, 'utf-8').css("#data-table tr").each do |tr|
      return tr.css("td").text if tr.css("th").text == "備考"
    end
    return nil
  end

  def map
    map = Nokogiri::HTML(@html, nil, 'utf-8').css("#minimap")
    return map.css("img").attr("src").content if map.present?
    return nil
  end

  def close_restaurants
    section = Nokogiri::HTML(@html, nil, 'utf-8').css("#shop-near")
    if section.present?
      close_restaurants = []
      section.css("li").each do |li|
        close_restaurants.push li.css("a").attr("href").content.split("s/")[1].split(".html")[0]
      end
      return close_restaurants
    end
    return nil
  end

  def html
    @html
  end
end
